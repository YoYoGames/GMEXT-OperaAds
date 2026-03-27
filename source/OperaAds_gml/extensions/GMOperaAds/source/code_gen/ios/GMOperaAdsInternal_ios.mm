// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMOperaAdsInternal_ios.h"


extern "C" const char* extOptGetString(char* _ext, char* _opt);

// Adapter: matches const signature expected by your C++ API
static const char* ExtOptGetString(const char* ext, const char* opt)
{
    return extOptGetString(const_cast<char*>(ext), const_cast<char*>(opt));
}

static BOOL GMIsSubclassOf(Class cls, Class base)
{
    for (Class c = cls; c != Nil; c = class_getSuperclass(c)) {
        if (c == base) return YES;
    }
    return NO;
}

static void GMInjectSelectorsIntoSubclass(Class subclass, Class base)
{
    // Build set of methods already defined on subclass
    unsigned subCount = 0;
    Method *subList = class_copyMethodList(subclass, &subCount);

    CFMutableSetRef owned = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
    for (unsigned i = 0; i < subCount; ++i) {
        CFSetAddValue(owned, method_getName(subList[i]));
    }

    // Walk base class methods
    unsigned baseCount = 0;
    Method *baseList = class_copyMethodList(base, &baseCount);

    for (unsigned i = 0; i < baseCount; ++i) {
        SEL sel = method_getName(baseList[i]);
        const char *name = sel_getName(sel);

        // Only inject your extension selectors
        if (!name || strncmp(name, "__EXT_NATIVE__", 13) != 0) continue;

        // Add only if subclass doesn't already have it
        if (!CFSetContainsValue(owned, sel)) {
            IMP imp = method_getImplementation(baseList[i]);
            const char *types = method_getTypeEncoding(baseList[i]);
            if (class_addMethod(subclass, sel, imp, types)) {
                CFSetAddValue(owned, sel);
            }
        }
    }

    if (subList) free(subList);
    if (baseList) free(baseList);
    if (owned) CFRelease(owned);
}

@interface GMOperaAdsInternal ()
{
    gm::runtime::DispatchQueue __dispatch_queue;
    id<GMOperaAdsInterface> __impl;
}@end


@implementation GMOperaAdsInternal

+ (void)load
{
    // Find all loaded classes
    int num = objc_getClassList(NULL, 0);
    if (num <= 0) return;

    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned)num);
    num = objc_getClassList(classes, num);

    Class base = [GMOperaAdsInternal class];

    for (int i = 0; i < num; ++i) {
        Class cls = classes[i];
        if (cls == base) continue;

        // We only care about direct or indirect subclasses
        if (GMIsSubclassOf(cls, base)) {
            GMInjectSelectorsIntoSubclass(cls, base);
        }
    }

    free(classes);

    gm::details::GMRTRunnerInterface ri{};
    ri.ExtOptGetString = &ExtOptGetString;
    GMExtensionInitialise(&ri, sizeof(ri));
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        __impl = (id<GMOperaAdsInterface>)self;
    }
    return self;
}
- (double)__EXT_NATIVE__opera_ads_init:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    bool __result = [__impl opera_ads_init:callback];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_set_mute:(double)mute
{
    bool __result = [__impl opera_ads_set_mute:mute];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_set_gdpr:(char*)consent_string arg1:(double)applies
{
    [__impl opera_ads_set_gdpr:consent_string applies:static_cast<bool>(applies)];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_set_us_privacy:(char*)us_privacy
{
    [__impl opera_ads_set_us_privacy:us_privacy];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_set_coppa:(double)coppa
{
    [__impl opera_ads_set_coppa:coppa];

    return 0;
}

- (char*)__EXT_NATIVE__opera_ads_get_gdpr
{
    static std::string __result;
    __result = [__impl opera_ads_get_gdpr];

    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__opera_ads_get_gdpr_applies
{
    bool __result = [__impl opera_ads_get_gdpr_applies];

    return static_cast<double>(__result);
}

- (char*)__EXT_NATIVE__opera_ads_get_us_privacy
{
    static std::string __result;
    __result = [__impl opera_ads_get_us_privacy];

    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__opera_ads_get_coppa
{
    bool __result = [__impl opera_ads_get_coppa];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_interstitial_set_placement_id:(char*)placement_id
{
    [__impl opera_ads_interstitial_set_placement_id:placement_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_placement_id:(char*)placement_id
{
    [__impl opera_ads_rewarded_set_placement_id:placement_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id:(char*)placement_id
{
    [__impl opera_ads_rewarded_interstitial_set_placement_id:placement_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_app_open_set_placement_id:(char*)placement_id
{
    [__impl opera_ads_app_open_set_placement_id:placement_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_banner_set_placement_id:(char*)placement_id
{
    [__impl opera_ads_banner_set_placement_id:placement_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_interstitial_load:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_is_ad_valid
{
    bool __result = [__impl opera_ads_interstitial_is_ad_valid];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_interstitial_show:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_destroy
{
    bool __result = [__impl opera_ads_interstitial_destroy];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_rewarded_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_rewarded_load:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_is_ad_valid
{
    bool __result = [__impl opera_ads_rewarded_is_ad_valid];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_rewarded_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_rewarded_show:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_destroy
{
    bool __result = [__impl opera_ads_rewarded_destroy];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_rewarded_interstitial_load:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid
{
    bool __result = [__impl opera_ads_rewarded_interstitial_is_ad_valid];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_rewarded_interstitial_show:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_destroy
{
    bool __result = [__impl opera_ads_rewarded_interstitial_destroy];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_app_open_enable:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_app_open_enable:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_app_open_disable
{
    bool __result = [__impl opera_ads_app_open_disable];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_app_open_is_enabled
{
    bool __result = [__impl opera_ads_app_open_is_enabled];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    [__impl opera_ads_banner_load:callback];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_banner_is_ad_valid
{
    bool __result = [__impl opera_ads_banner_is_ad_valid];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: position, type: enum OperaAdsBannerPosition
    gm_enums::OperaAdsBannerPosition position = gm::wire::codec::readValue<gm_enums::OperaAdsBannerPosition>(__br);

    bool __result = [__impl opera_ads_banner_show:position];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_move:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: position, type: enum OperaAdsBannerPosition
    gm_enums::OperaAdsBannerPosition position = gm::wire::codec::readValue<gm_enums::OperaAdsBannerPosition>(__br);

    bool __result = [__impl opera_ads_banner_move:position];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_destroy
{
    bool __result = [__impl opera_ads_banner_destroy];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_hide
{
    bool __result = [__impl opera_ads_banner_hide];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_unhide
{
    bool __result = [__impl opera_ads_banner_unhide];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_banner_is_visible
{
    bool __result = [__impl opera_ads_banner_is_visible];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_scene:(char*)scene_id
{
    [__impl opera_ads_rewarded_set_scene:scene_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data
{
    [__impl opera_ads_rewarded_set_reward_ssv_options:user_id custom_data:custom_data];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene:(char*)scene_id
{
    [__impl opera_ads_rewarded_interstitial_set_scene:scene_id];

    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data
{
    [__impl opera_ads_rewarded_interstitial_set_reward_ssv_options:user_id custom_data:custom_data];

    return 0;
}

// Internal function used for fetching dispatched function calls to GML
- (double)__EXT_NATIVE__GMOperaAds_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

@end

