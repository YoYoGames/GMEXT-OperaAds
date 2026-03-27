
#import "objc/runtime.h"
#import "GMOperaAds_ios.h"

extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;

extern "C" void dsMapClear(int _dsMap );
extern "C" int dsMapCreate();
extern "C" void dsMapAddInt(int _dsMap, char* _key, int _value);
extern "C" void dsMapAddDouble(int _dsMap, char* _key, double _value);
extern "C" void dsMapAddString(int _dsMap, char* _key, char* _value);

extern "C" int dsListCreate();
extern "C" void dsListAddInt(int _dsList, int _value);
extern "C" void dsListAddString(int _dsList, char* _value);
extern "C" const char* dsListGetValueString(int _dsList, int _listIdx);
extern "C" double dsListGetValueDouble(int _dsList, int _listIdx);
extern "C" int dsListGetSize(int _dsList);

extern "C" const char* extOptGetString(char* _ext, char* _opt);
extern "C" const char* extGetVersion(char* _ext);

extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);


@implementation GMOperaAds

static const char* kOperaAdsNotInitializedError = "Opera Ads SDK is not initialized.";

static inline NSString *OperaAdsNSStringFromStringView(std::string_view value) {
    if (value.data() == nullptr || value.size() == 0) return @"";
    NSString *result = [[NSString alloc] initWithBytes:value.data()
                                                length:value.size()
                                              encoding:NSUTF8StringEncoding];
    return result ? result : @"";
}

static inline NSString *OperaAdsNSStringFromStdString(const std::string &value) {
    if (value.empty()) return @"";
    NSString *result = [[NSString alloc] initWithBytes:value.data()
                                                length:value.size()
                                              encoding:NSUTF8StringEncoding];
    return result ? result : @"";
}

+ (void)load {
    // 1) snapshot methods defined *directly* on the subclass
    unsigned subCount = 0;
    Method *subList = class_copyMethodList(self, &subCount);

    // build a set of SELs the subclass already owns
    CFMutableSetRef owned = CFSetCreateMutable(kCFAllocatorDefault, 0, nil);
    for (unsigned i = 0; i < subCount; ++i) {
        SEL sel = method_getName(subList[i]);
        CFSetAddValue(owned, sel);
    }

    // 2) walk the superclass’s instance methods
    unsigned supCount = 0;
    Method *supList = class_copyMethodList([GMOperaAdsInternal class], &supCount);

    for (unsigned i = 0; i < supCount; ++i) {
        SEL sel = method_getName(supList[i]);

        // (optional) only copy your extension selectors
        const char *name = sel_getName(sel);
        if (!name || strncmp(name, "__EXT_NATIVE__", 13) != 0) continue;

        // only add if NOT already defined on subclass
        if (!CFSetContainsValue(owned, sel)) {
            IMP imp = method_getImplementation(supList[i]);
            const char *types = method_getTypeEncoding(supList[i]);
            if (class_addMethod(self, sel, imp, types)) {
                // remember we added it (avoid re-adding if +load ever runs twice)
                CFSetAddValue(owned, sel);
            }
        }
    }

    // 3) cleanup
    if (subList) free(subList);
    if (supList) free(supList);
    if (owned) CFRelease(owned);
}

bool opera_ads_initialized = false;
bool opera_ads_displaying_ad = false;

- (bool)opera_ads_init:(gm::wire::GMFunction)callback{

    std::string app_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS Application Id");
    NSString *applicationId = OperaAdsNSStringFromStdString(app_id);

    std::string ios_app_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS App Id");
    NSString *iOSAppId = OperaAdsNSStringFromStdString(ios_app_id);

    std::string interstitial_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS Interstitial");
    std::string rewarded_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS Rewarded");
    std::string rewarded_interstitial_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS Rewarded Interstitial");
    std::string app_open_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS App Open");
    std::string banner_id = gm::ExtUtils::GetExtensionOption("GMOperaAds","iOS Banner");

    self.interstitialPlacementId = OperaAdsNSStringFromStdString(interstitial_id);
    self.rewardedPlacementId = OperaAdsNSStringFromStdString(rewarded_id);
    self.rewardedInterstitialPlacementId = OperaAdsNSStringFromStdString(rewarded_interstitial_id);
    self.appOpenPlacementId = OperaAdsNSStringFromStdString(app_open_id);
    self.bannerPlacementId = OperaAdsNSStringFromStdString(banner_id);

    self.bannerPosition = gm_enums::OperaAdsBannerPosition::TopCenter;
    self.bannerAdded = NO;
    self.bannerConstraints = @[];
    self.bannerVisible = NO;
    self.bannerLoaded = NO;
    self.bannerLoadedOnce = NO;
    self.bannerLoadInProgress = NO;

    OpAdxSdkInitConfig *initConfig = [OpAdxSdkInitConfig createWithApplicationId: applicationId iOSAppId:iOSAppId publisherName:nil];
            
    // initConfig.useTestAd = YES;
    [OpAdxSdkCore.shared initializeSDKWithConfig:initConfig];
    
    callback.call(TRUE);
    
    opera_ads_initialized = true;
    
    return true;
}

- (bool)opera_ads_set_mute:(bool)mute{
    if(!opera_ads_initialized) return false;
    [OpAdxSdkCore setOpAdxSdkMuted:mute?@1:@0];
    return true;

}

- (void)opera_ads_set_gdpr:(std::string_view)consent_string applies:(bool)applies{
    NSString *consentString = [[NSString alloc] initWithBytes:consent_string.data() length:consent_string.size() encoding:NSUTF8StringEncoding];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:(applies ? 1 : 0) forKey:@"IABTCF_gdprApplies"];
    [defaults setObject:(consentString ? consentString : @"") forKey:@"IABTCF_TCString"];
    [defaults synchronize];
}

- (void)opera_ads_set_us_privacy:(std::string_view)us_privacy{
    NSString *usPrivacy = [[NSString alloc] initWithBytes:us_privacy.data() length:us_privacy.size() encoding:NSUTF8StringEncoding];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:(usPrivacy ? usPrivacy : @"") forKey:@"IABUSPrivacy_String"];
    [defaults synchronize];
}

- (void)opera_ads_set_coppa:(bool)coppa{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:(coppa ? 1 : 0) forKey:@"opera_ads_coppa"];
    [defaults synchronize];
}

- (std::string)opera_ads_get_gdpr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults stringForKey:@"IABTCF_TCString"];
    return value ? std::string(value.UTF8String) : std::string();
}

- (bool)opera_ads_get_gdpr_applies{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"IABTCF_gdprApplies"] == 1;
}

- (std::string)opera_ads_get_us_privacy{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults stringForKey:@"IABUSPrivacy_String"];
    return value ? std::string(value.UTF8String) : std::string();
}

- (bool)opera_ads_get_coppa{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults integerForKey:@"opera_ads_coppa"] == 1;
}

- (void)opera_ads_interstitial_set_placement_id:(std::string_view)placement_id{
    self.interstitialPlacementId = OperaAdsNSStringFromStringView(placement_id);
}

- (void)opera_ads_rewarded_set_placement_id:(std::string_view)placement_id{
    self.rewardedPlacementId = OperaAdsNSStringFromStringView(placement_id);
}

- (void)opera_ads_rewarded_interstitial_set_placement_id:(std::string_view)placement_id{
    self.rewardedInterstitialPlacementId = OperaAdsNSStringFromStringView(placement_id);
}

- (void)opera_ads_app_open_set_placement_id:(std::string_view)placement_id{
    NSString *value = OperaAdsNSStringFromStringView(placement_id);
    self.appOpenPlacementId = value;
    self.openAdsPlacementIdActive = value;
    if (self.appOpenAd) {
        [self opera_ads_app_open_destroy];
    }
}

- (void)opera_ads_banner_set_placement_id:(std::string_view)placement_id{
    self.bannerPlacementId = OperaAdsNSStringFromStringView(placement_id);
}
gm::wire::GMFunction interstitial_load_callback = nil;
- (void)opera_ads_interstitial_load:(gm::wire::GMFunction)callback{
    NSString *placementId = self.interstitialPlacementId ? self.interstitialPlacementId : @"";

    if(!opera_ads_initialized){
        callback.call(FALSE, kOperaAdsNotInitializedError);
        return;
    }

    if (placementId.length == 0) {
        callback.call(FALSE, "Interstitial placement ID is empty.");
        return;
    }
    
    OpAdxInterstitialAdBridge *interstitialAd = [[OpAdxInterstitialAdBridge alloc] initWithPlacementId:placementId auctionType: AdAuctionTypeRegular];
    self.interstitialAd = interstitialAd;
    interstitialAd.delegate = self;
    [interstitialAd loadAd];
    interstitial_load_callback = callback;
}

    - (void)interstitialAdDidLoad:(OpAdxInterstitialAdBridge *)interstitialAd {
        NSLog(@"Interstitial ad loaded.");
        interstitial_load_callback.call(TRUE);
    }

    - (void)interstitialAd:(OpAdxInterstitialAdBridge *)interstitialAd didFailWithError:(OpAdxAdError *)error {
        NSLog(@"Interstitial ad failed to load: %@", error.message);
        interstitial_load_callback.call(FALSE,error.message.UTF8String);
    }
    

- (bool)opera_ads_interstitial_is_ad_valid{
    
    if(!opera_ads_initialized)
        return false;
    
    if (!self.interstitialAd)
        return FALSE;
    
    return [self.interstitialAd isAdValid];
}

gm::wire::GMFunction interstitial_show_callback = nil;
- (void)opera_ads_interstitial_show:(gm::wire::GMFunction)callback{
    
    if(!opera_ads_initialized){
        callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Failed, kOperaAdsNotInitializedError);
        return;
    }
    
    if (!self.interstitialAd) {
        callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Failed, "Interstitial ad is not loaded.");
        return;
    }
    
    if (![self.interstitialAd isAdValid]) {
        [self opera_ads_interstitial_destroy];
        callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Failed, "Interstitial ad is invalid.");
        return;
    }
    
    opera_ads_displaying_ad = true;
    interstitial_show_callback = callback;
    [self.interstitialAd showAdFrom:g_controller];
}

    - (void)interstitialAdDidClick:(OpAdxInterstitialAdBridge *)interstitialAd {
        interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Clicked);
    }

    - (void)interstitialAdDidClose:(OpAdxInterstitialAdBridge *)interstitialAd {
        interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Dismissed);
        self.interstitialAd = nil;
        opera_ads_displaying_ad = false;
    }

    - (void)interstitialAdWillLogImpression:(OpAdxInterstitialAdBridge *)interstitialAd {
        interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventInterstitial::Displayed);
    }

    //SHOW ERROR EVENT?

- (bool)opera_ads_interstitial_destroy{
    self.interstitialAd = nil;
    return true;
}

gm::wire::GMFunction rewarded_load_callback = nil;
- (void)opera_ads_rewarded_load:(gm::wire::GMFunction)callback{
    NSString *placementId = self.rewardedPlacementId;

    if(!opera_ads_initialized){
        callback.call(FALSE, kOperaAdsNotInitializedError);
        return;
    }
    
    OpAdxRewardedAdBridge *rewardedAd = [[OpAdxRewardedAdBridge alloc] initWithPlacementId:placementId auctionType: AdAuctionTypeRegular];
    self.rewardedAd = rewardedAd;
    rewardedAd.delegate = self;
    
    rewarded_load_callback = callback;
    [rewardedAd loadAd];
}

- (bool)opera_ads_rewarded_is_ad_valid{
    
    if(!opera_ads_initialized)
        return false;
    
    if (!self.rewardedAd)
        return FALSE;
    
    return [self.rewardedAd isAdValid];
}

gm::wire::GMFunction rewarded_show_callback = nil;
- (void)opera_ads_rewarded_show:(gm::wire::GMFunction)callback{
    
    if(!opera_ads_initialized){
        callback.call(gm_enums::OperaAdsCallbackEventRewarded::Failed, kOperaAdsNotInitializedError);
        return;
    }
    
    if (!self.rewardedAd) {
        callback.call(gm_enums::OperaAdsCallbackEventRewarded::Failed, "Rewarded ad is not loaded.");
        return;
    }
    
    if (![self.rewardedAd isAdValid]) {
        [self opera_ads_rewarded_destroy];
        callback.call(gm_enums::OperaAdsCallbackEventRewarded::Failed, "Rewarded ad is invalid.");
        return;
    }
    
    opera_ads_displaying_ad = true;
    rewarded_show_callback = callback;
    [self.rewardedAd showAdFrom:g_controller];
}

- (bool)opera_ads_rewarded_destroy{
    self.rewardedAd = nil;
    return true;
}

    - (void)rewardedAdDidLoad:(OpAdxRewardedAdBridge *)rewardedAd {
        rewarded_load_callback.call(TRUE);
    }

    - (void)rewardedAd:(OpAdxRewardedAdBridge *)rewardedAd didFailWithError:(OpAdxAdError *)error {
        rewarded_load_callback.call(false,error.message.UTF8String);
    }

    - (void)rewardedAdDidClick:(OpAdxRewardedAdBridge *)rewardedAd {
        rewarded_show_callback.call(gm_enums::OperaAdsCallbackEventRewarded::Clicked);
    }

    - (void)rewardedAdDidClose:(OpAdxRewardedAdBridge *)rewardedAd {
        rewarded_show_callback.call(gm_enums::OperaAdsCallbackEventRewarded::Dismissed);
        opera_ads_displaying_ad = false;
        self.rewardedAd = nil;
    }

    - (void)rewardedAd:(OpAdxRewardedAdBridge *)rewardedAd didRewardUserWithItem:(OpAdxRewardItem *)rewardItem {
        rewarded_show_callback.call(gm_enums::OperaAdsCallbackEventRewarded::Rewarded,[rewardItem.type UTF8String],(int)rewardItem.amount);
    }

    - (void)rewardedAdWillLogImpression:(OpAdxRewardedAdBridge *)rewardedAd {
        rewarded_show_callback.call(gm_enums::OperaAdsCallbackEventRewarded::Displayed);
    }

gm::wire::GMFunction rewarded_interstitial_load_callback = nil;
- (void)opera_ads_rewarded_interstitial_load:(gm::wire::GMFunction)callback{
    
    if(!opera_ads_initialized){
        callback.call(FALSE, kOperaAdsNotInitializedError);
        return;
    }
    NSString *placementId = self.rewardedInterstitialPlacementId;

    OpAdxRewardedInterstitialAdBridge *rewardedInterstitialAd = [[OpAdxRewardedInterstitialAdBridge alloc] initWithPlacementId:placementId auctionType: AdAuctionTypeRegular];
    self.rewardedInterstitialAd = rewardedInterstitialAd;
    rewardedInterstitialAd.delegate = self;
    rewarded_interstitial_load_callback = callback;
    [rewardedInterstitialAd loadAd];
}

- (bool)opera_ads_rewarded_interstitial_is_ad_valid{
    
    if(!opera_ads_initialized)
        return false;
    
    if (!self.rewardedInterstitialAd)
        return FALSE;
    
    return [self.rewardedInterstitialAd isAdValid];
}

gm::wire::GMFunction rewarded_interstitial_show_callback = nil;
- (void)opera_ads_rewarded_interstitial_show:(gm::wire::GMFunction)callback{
    
    if(!opera_ads_initialized){
        callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Failed, kOperaAdsNotInitializedError);
        return;
    }
    
    if (!self.rewardedInterstitialAd) {
        callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Failed, "Rewarded interstitial ad is not loaded.");
        return;
    }
    
    if (![self.rewardedInterstitialAd isAdValid]) {
        [self opera_ads_rewarded_interstitial_destroy];
        callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Failed, "Rewarded interstitial ad is invalid.");
        return;
    }
    
    opera_ads_displaying_ad = true;
    rewarded_interstitial_show_callback = callback;
    [self.rewardedInterstitialAd showAdFrom:g_controller];
}

- (bool)opera_ads_rewarded_interstitial_destroy{
    self.rewardedInterstitialAd = nil;
    return true;
}

    - (void)rewardedInterstitialAdDidLoad:(OpAdxRewardedInterstitialAdBridge *)rewardedInterstitialAd {
        rewarded_interstitial_load_callback.call(TRUE);
    }

    - (void)rewardedInterstitialAd:(OpAdxRewardedInterstitialAdBridge *)rewardedInterstitialAd didFailWithError:(OpAdxAdError *)error {
        rewarded_interstitial_load_callback.call(false,error.message.UTF8String);
    }

    - (void)rewardedInterstitialAdDidClick:(OpAdxRewardedInterstitialAdBridge *)rewardedInterstitialAd {
        rewarded_interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Clicked);
    }

    - (void)rewardedInterstitialAdDidClose:(OpAdxRewardedInterstitialAdBridge *)rewardedInterstitialAd {
        rewarded_interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Dismissed);
        self.rewardedInterstitialAd = nil;
        opera_ads_displaying_ad = false;
    }

    - (void)rewardedInterstitialAdWillLogImpression:(OpAdxRewardedInterstitialAdBridge *)rewardedInterstitialAd {
            rewarded_interstitial_show_callback.call(gm_enums::OperaAdsCallbackEventRewardedInterstitial::Displayed);
    }

gm::wire::GMFunction app_open_callback = nil;
- (void)opera_ads_app_open_enable:(gm::wire::GMFunction)callback{

    if(!opera_ads_initialized){
        callback.call(gm_enums::OperaAdsCallbackEventAppOpen::LoadFailed, kOperaAdsNotInitializedError);
        return;
    }
        
    self.openAdsPlacementIdActive = self.appOpenPlacementId ? self.appOpenPlacementId : @"";
    if (self.openAdsPlacementIdActive.length == 0) {
        callback.call(gm_enums::OperaAdsCallbackEventAppOpen::LoadFailed, "App open placement ID is empty.");
        return;
    }

    app_open_callback = callback;
    [self opera_ads_app_open_load: self.openAdsPlacementIdActive];
}

- (bool)opera_ads_app_open_disable{
    if(!opera_ads_initialized)
        return false;
    self.openAdsPlacementIdActive = @"";
    app_open_callback = nil;
    opera_ads_displaying_ad = false;
    [self opera_ads_app_open_destroy];
    return true;
}

- (bool)opera_ads_app_open_is_enabled{
    
    if(!opera_ads_initialized)
        return false;

    return self.openAdsPlacementIdActive.length != 0;
}



- (void)opera_ads_app_open_load:(NSString*)placement_id{
    NSString *activePlacementId = placement_id ? placement_id : @"";

    if(!opera_ads_initialized){
        NSLog(@"[OperaAds][iOS] App open load skipped: SDK not initialized.");
        return;
    }

    if (activePlacementId.length == 0) {
        NSLog(@"[OperaAds][iOS] App open load skipped: app open is disabled or placement ID is empty.");
        return;
    }

    OpAdxAppOpenAdBridge *appOpenAd = [[OpAdxAppOpenAdBridge alloc] initWithPlacementId:activePlacementId auctionType: AdAuctionTypeRegular];
    self.appOpenAd = appOpenAd;
    appOpenAd.delegate = self;
    [appOpenAd loadAd];
}

- (bool)opera_ads_app_open_is_ad_valid{
    if (!self.appOpenAd)
        return FALSE;
    
    return [self.appOpenAd isAdValid];
}


- (void)opera_ads_app_open_show{
    if(!opera_ads_initialized){
        NSLog(@"[OperaAds][iOS] App open show skipped: SDK not initialized.");
        return;
    }

    if (![self opera_ads_app_open_is_enabled]) {
        NSLog(@"[OperaAds][iOS] App open show skipped: app open is disabled.");
        return;
    }

    if (!self.appOpenAd) {
        NSLog(@"[OperaAds][iOS] App open show skipped: no loaded app open ad.");
        return;
    }
    
    if (![self.appOpenAd isAdValid]) {
        NSLog(@"[OperaAds][iOS] App open show skipped: ad is invalid.");
        [self opera_ads_app_open_destroy];
        return;
    }
    
    [self.appOpenAd showAdFrom:g_controller];
}

- (void)opera_ads_app_open_destroy{
    self.appOpenAd = nil;
}

    - (void)appOpenAdDidLoad:(OpAdxAppOpenAdBridge *)appOpenAd {
        if(app_open_callback)
            app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Loaded);
    }

    - (void)appOpenAd:(OpAdxAppOpenAdBridge *)appOpenAd didFailWithError:(OpAdxAdError *)error {
        if (opera_ads_displaying_ad) {
            // opera_ads_displaying_ad = false;
            [self opera_ads_app_open_destroy];
            if(app_open_callback)
                app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Failed,error.message.UTF8String);
        } else {
            if(app_open_callback)
                app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::LoadFailed,error.message.UTF8String);
        }
    }

    - (void)appOpenAdDidClick:(OpAdxAppOpenAdBridge *)appOpenAd {
        if(app_open_callback)
            app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Clicked);
    }

    - (void)appOpenAdDidDisplay:(OpAdxAppOpenAdBridge *)appOpenAd {
        // opera_ads_displaying_ad = true;
        [self opera_ads_app_open_load:self.openAdsPlacementIdActive];
        if(app_open_callback)
            app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Displayed);
    }

    - (void)appOpenAdDidClose:(OpAdxAppOpenAdBridge *)appOpenAd {
        [self opera_ads_app_open_destroy];
        // opera_ads_displaying_ad = false;
        if(app_open_callback)
            app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Dismissed);
    }

    - (void)appOpenAdWillLogImpression:(OpAdxAppOpenAdBridge *)appOpenAd {
        if(app_open_callback)
            app_open_callback.call(gm_enums::OperaAdsCallbackEventAppOpen::Displayed);
    }


- (NSArray<NSLayoutConstraint *> *)constraintsForBanner:(UIView *)banner
                                               inView:(UIView *)container
                                             position:(gm_enums::OperaAdsBannerPosition)position
{
    UILayoutGuide *safe = container.safeAreaLayoutGuide;

    CGFloat bw = OpAdxAdSize.BANNER_MREC.width;
    CGFloat bh = OpAdxAdSize.BANNER_MREC.height;

    NSMutableArray<NSLayoutConstraint *> *c = [NSMutableArray array];

    // MUST HAVE SIZE, otherwise banner can be 0x0
    [c addObject:[banner.widthAnchor constraintEqualToConstant:bw]];
    [c addObject:[banner.heightAnchor constraintEqualToConstant:bh]];

    switch (position) {
        case gm_enums::OperaAdsBannerPosition::TopLeft:
            [c addObject:[banner.topAnchor constraintEqualToAnchor:safe.topAnchor]];
            [c addObject:[banner.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::TopCenter:
            [c addObject:[banner.topAnchor constraintEqualToAnchor:safe.topAnchor]];
            [c addObject:[banner.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::TopRight:
            [c addObject:[banner.topAnchor constraintEqualToAnchor:safe.topAnchor]];
            [c addObject:[banner.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::MiddleLeft:
            [c addObject:[banner.centerYAnchor constraintEqualToAnchor:safe.centerYAnchor]];
            [c addObject:[banner.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::MiddleCenter:
            [c addObject:[banner.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor]];
            [c addObject:[banner.centerYAnchor constraintEqualToAnchor:safe.centerYAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::MiddleRight:
            [c addObject:[banner.centerYAnchor constraintEqualToAnchor:safe.centerYAnchor]];
            [c addObject:[banner.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::BottomLeft:
            [c addObject:[banner.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor]];
            [c addObject:[banner.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::BottomCenter:
            [c addObject:[banner.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor]];
            [c addObject:[banner.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor]];
            break;

        case gm_enums::OperaAdsBannerPosition::BottomRight:
            [c addObject:[banner.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor]];
            [c addObject:[banner.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor]];
            break;

        default:
            [c addObject:[banner.topAnchor constraintEqualToAnchor:safe.topAnchor]];
            [c addObject:[banner.centerXAnchor constraintEqualToAnchor:safe.centerXAnchor]];
            break;
    }

    return c;
}

- (void)applyBannerPositionConstraints
{
    UIView *banner = (UIView *)self.bannerAdView;
    if (!banner) return;

    UIView *container = g_glView; // your GL view
    if (!container) return;

    banner.translatesAutoresizingMaskIntoConstraints = NO;

    // remove old constraints
    if (self.bannerConstraints.count > 0) {
        [NSLayoutConstraint deactivateConstraints:self.bannerConstraints];
    }

    self.bannerConstraints = [self constraintsForBanner:banner
                                                 inView:container
                                               position:self.bannerPosition];

    [NSLayoutConstraint activateConstraints:self.bannerConstraints];

    [container setNeedsLayout];
    [container layoutIfNeeded];
}


gm::wire::GMFunction banner_load_callback = nil;
- (void)opera_ads_banner_load:(gm::wire::GMFunction)callback{

    if(!opera_ads_initialized) {
        callback.call(gm_enums::OperaAdsCallbackEventBanner::LoadFailed, kOperaAdsNotInitializedError);
        return;
    }

    NSString *placementId = self.bannerPlacementId ? self.bannerPlacementId : @"";

    if (placementId.length == 0) {
        callback.call(gm_enums::OperaAdsCallbackEventBanner::LoadFailed, "Banner placement ID is empty.");
        return;
    }

    if (self.bannerLoadedOnce) {
        callback.call(gm_enums::OperaAdsCallbackEventBanner::LoadFailed, "Banner ad view has already been loaded. Destroy it before loading again.");
        return;
    }

    if (self.bannerLoadInProgress) {
        callback.call(gm_enums::OperaAdsCallbackEventBanner::LoadFailed, "Banner ad load is already in progress.");
        return;
    }

    self.bannerLoadInProgress = YES;

    OpAdxBannerAdBridge *bannerAd = [[OpAdxBannerAdBridge alloc] initWithPlacementId:placementId adSize:OpAdxAdSize.BANNER_MREC];
    self.bannerAdView = bannerAd;
    bannerAd.delegate = self;
    banner_load_callback = callback;
    [bannerAd loadAd];
}

- (bool)opera_ads_banner_is_ad_valid{
    if(!opera_ads_initialized)
        return false;

    if (!self.bannerAdView)
        return FALSE;

    if (!self.bannerLoaded)
        return false;

    return true;//[self.bannerAdView isAdValid];
}

- (bool)opera_ads_banner_show:(gm_enums::OperaAdsBannerPosition)position
{
    if (!opera_ads_initialized) return false;
    if (!self.bannerAdView) return false;

    self.bannerPosition = (gm_enums::OperaAdsBannerPosition)position;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *banner = (UIView *)self.bannerAdView;
        UIView *container = g_glView;
        if (!banner || !container) return;

        if (!self.bannerAdded) {
            // detach from any parent first
            if (banner.superview) {
                [banner removeFromSuperview];
            }
            [container addSubview:banner];
            self.bannerAdded = YES;
        }

        [self applyBannerPositionConstraints];

        self.bannerVisible = YES;
    });
    return true;
}

- (bool)opera_ads_banner_move:(gm_enums::OperaAdsBannerPosition)position
{
    if (!opera_ads_initialized) return false;
    if (!self.bannerAdView) return false;
    if (!self.bannerAdded) return false;

    self.bannerPosition = (gm_enums::OperaAdsBannerPosition)position;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self applyBannerPositionConstraints];
    });
    return true;
}


- (bool)opera_ads_banner_destroy
{
    if (!opera_ads_initialized) return false;
    self.bannerLoadInProgress = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *banner = (UIView *)self.bannerAdView;

        if (self.bannerConstraints.count > 0) {
            [NSLayoutConstraint deactivateConstraints:self.bannerConstraints];
            self.bannerConstraints = @[];
        }

        if (banner.superview) {
            [banner removeFromSuperview];
        }

        [self.bannerAdView destroy];
        self.bannerAdView = nil;

        self.bannerAdded = NO;
        self.bannerVisible = NO;
        self.bannerLoaded = NO;
        self.bannerLoadedOnce = NO;
        self.bannerLoadInProgress = NO;
    });
    return true;
}

- (bool)opera_ads_banner_hide
{
    if (!opera_ads_initialized) return false;
    if (!self.bannerAdView) return false;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *banner = (UIView *)self.bannerAdView;

        banner.hidden = YES;
        banner.alpha = 0.0;

        self.bannerVisible = NO;
    });
    return true;
}

- (bool)opera_ads_banner_unhide
{
    if (!opera_ads_initialized) return false;
    if (!self.bannerAdView) return false;
    if (!self.bannerLoaded) return false;

    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *banner = (UIView *)self.bannerAdView;

        banner.hidden = NO;
        banner.alpha = 1.0;

        if (banner.superview)
            [banner.superview bringSubviewToFront:banner];

        self.bannerVisible = YES;
    });
    return true;
}

- (bool)opera_ads_banner_is_visible
{
    return self.bannerVisible;
}


    - (void)bannerAdDidLoad:(OpAdxBannerAdBridge *)bannerAd {
        self.bannerLoaded = YES;
        self.bannerLoadedOnce = YES;
        self.bannerLoadInProgress = NO;
        banner_load_callback.call(gm_enums::OperaAdsCallbackEventBanner::Loaded);
    }

    - (void)bannerAd:(OpAdxBannerAdBridge *)bannerAd didFailWithError:(OpAdxAdError *)error {
        self.bannerLoaded = NO;
        self.bannerLoadInProgress = NO;
        [self opera_ads_banner_destroy];
        banner_load_callback.call(gm_enums::OperaAdsCallbackEventBanner::LoadFailed,error.message.UTF8String);
    }

    - (void)bannerAdDidClick:(OpAdxBannerAdBridge *)bannerAd {
        banner_load_callback.call(gm_enums::OperaAdsCallbackEventBanner::Clicked);
    }

    - (void)bannerAdWillLogImpression:(OpAdxBannerAdBridge *)bannerAd {
        banner_load_callback.call(gm_enums::OperaAdsCallbackEventBanner::Impression);
    }


-(void) onResume
{
        if(!opera_ads_initialized) return;
        
        if(self.bannerAdView)
            [self.bannerAdView resume];
            
        // if (mBannerAdView != null) mBannerAdView.resume();
        
        Boolean show = false;
        if(!opera_ads_displaying_ad)
        {
            if([self opera_ads_app_open_is_enabled])
            if([self opera_ads_app_open_is_ad_valid])
                show = true;
            
            if(show)
                [self opera_ads_app_open_show];
            else
                [self opera_ads_app_open_load: self.openAdsPlacementIdActive];
        }
}

-(void) onStop
{
    if(self.bannerAdView)
        [self.bannerAdView pause];
}



-(void) onDestroy
{
    [self opera_ads_interstitial_destroy];
    [self opera_ads_rewarded_destroy];
    [self opera_ads_rewarded_interstitial_destroy];
    [self opera_ads_app_open_destroy];
    [self opera_ads_banner_destroy];

    interstitial_load_callback = nil;
    interstitial_show_callback = nil;
    rewarded_load_callback = nil;
    rewarded_show_callback = nil;
    rewarded_interstitial_load_callback = nil;
    rewarded_interstitial_show_callback = nil;
    app_open_callback = nil;
    banner_load_callback = nil;

    self.openAdsPlacementIdActive = @"";
    self.bannerConstraints = @[];
    self.bannerAdded = NO;
    self.bannerVisible = NO;
    self.bannerLoaded = NO;
    self.bannerLoadedOnce = NO;
    self.bannerLoadInProgress = NO;
    opera_ads_displaying_ad = false;
}

- (void)opera_ads_rewarded_set_scene:(std::string_view)scene_id{
    NSLog(@"[OperaAds][iOS] opera_ads_rewarded_set_scene: not supported on iOS; call ignored.");
}

- (void)opera_ads_rewarded_set_reward_ssv_options:(std::string_view)user_id custom_data:(std::string_view)custom_data{
    NSLog(@"[OperaAds][iOS] opera_ads_rewarded_set_reward_ssv_options: not supported on iOS; call ignored.");
}

- (void)opera_ads_rewarded_interstitial_set_scene:(std::string_view)scene_id{
    NSLog(@"[OperaAds][iOS] opera_ads_rewarded_interstitial_set_scene: not supported on iOS; call ignored.");
}

- (void)opera_ads_rewarded_interstitial_set_reward_ssv_options:(std::string_view)user_id custom_data:(std::string_view)custom_data{
    NSLog(@"[OperaAds][iOS] opera_ads_rewarded_interstitial_set_reward_ssv_options: not supported on iOS; call ignored.");
}

@end
