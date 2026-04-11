// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMOperaAdsInternal_ios.h"

#ifdef __cplusplus
#import "GMOperaAds-Swift.h"
using namespace GMOperaAds;
#endif


extern "C" const char* extOptGetString(char* _ext, char* _opt);

// Adapter: matches const signature expected by the C++ API
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

        // Only inject extension selectors (methods prefixed with __EXT_NATIVE__)
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
    GMOperaAdsSwift * __impl;
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
        #ifdef __cplusplus
        // Create Swift object once
        __impl = new GMOperaAdsSwift(GMOperaAdsSwift::init());
        #endif
    }
    return self;
}
- (double)__EXT_NATIVE__opera_ads_init:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    double __result = __impl->__EXT_SWIFT__opera_ads_init(__arg_buffer, __arg_buffer_length);
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_is_initialized
{
    double __result = __impl->__EXT_SWIFT__opera_ads_is_initialized();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_set_mute:(double)mute
{
    double __result = __impl->__EXT_SWIFT__opera_ads_set_mute(mute);
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_set_gdpr:(char*)consent_string arg1:(double)applies
{
    __impl->__EXT_SWIFT__opera_ads_set_gdpr(consent_string, applies);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_set_us_privacy:(char*)us_privacy
{
    __impl->__EXT_SWIFT__opera_ads_set_us_privacy(us_privacy);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_set_coppa:(double)coppa
{
    __impl->__EXT_SWIFT__opera_ads_set_coppa(coppa);
    return 0;
}

- (char*)__EXT_NATIVE__opera_ads_get_gdpr
{
    static std::string __result;
    __result = (std::string)__impl->__EXT_SWIFT__opera_ads_get_gdpr();
    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__opera_ads_get_gdpr_applies
{
    double __result = __impl->__EXT_SWIFT__opera_ads_get_gdpr_applies();
    return __result;
}

- (char*)__EXT_NATIVE__opera_ads_get_us_privacy
{
    static std::string __result;
    __result = (std::string)__impl->__EXT_SWIFT__opera_ads_get_us_privacy();
    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__opera_ads_get_coppa
{
    double __result = __impl->__EXT_SWIFT__opera_ads_get_coppa();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_set_placement_id:(char*)placement_id
{
    __impl->__EXT_SWIFT__opera_ads_interstitial_set_placement_id(placement_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_placement_id:(char*)placement_id
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_set_placement_id(placement_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id:(char*)placement_id
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_set_placement_id(placement_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_app_open_set_placement_id:(char*)placement_id
{
    __impl->__EXT_SWIFT__opera_ads_app_open_set_placement_id(placement_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_banner_set_placement_id:(char*)placement_id
{
    __impl->__EXT_SWIFT__opera_ads_banner_set_placement_id(placement_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_banner_set_auto_refresh:(double)interval
{
    __impl->__EXT_SWIFT__opera_ads_banner_set_auto_refresh(interval);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_interstitial_load(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_is_ad_valid
{
    double __result = __impl->__EXT_SWIFT__opera_ads_interstitial_is_ad_valid();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_interstitial_show(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_interstitial_destroy
{
    double __result = __impl->__EXT_SWIFT__opera_ads_interstitial_destroy();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_load(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_is_ad_valid
{
    double __result = __impl->__EXT_SWIFT__opera_ads_rewarded_is_ad_valid();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_show(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_destroy
{
    double __result = __impl->__EXT_SWIFT__opera_ads_rewarded_destroy();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_load(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid
{
    double __result = __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_is_ad_valid();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_show(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_destroy
{
    double __result = __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_destroy();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_app_open_enable:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_app_open_enable(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_app_open_disable
{
    double __result = __impl->__EXT_SWIFT__opera_ads_app_open_disable();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_app_open_is_enabled
{
    double __result = __impl->__EXT_SWIFT__opera_ads_app_open_is_enabled();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    __impl->__EXT_SWIFT__opera_ads_banner_load(__arg_buffer, __arg_buffer_length);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_banner_is_ad_valid
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_is_ad_valid();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_show(__arg_buffer, __arg_buffer_length);
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_move:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_move(__arg_buffer, __arg_buffer_length);
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_destroy
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_destroy();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_hide
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_hide();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_unhide
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_unhide();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_banner_is_visible
{
    double __result = __impl->__EXT_SWIFT__opera_ads_banner_is_visible();
    return __result;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_scene:(char*)scene_id
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_set_scene(scene_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_set_reward_ssv_options(user_id, custom_data);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene:(char*)scene_id
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_set_scene(scene_id);
    return 0;
}

- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data
{
    __impl->__EXT_SWIFT__opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id, custom_data);
    return 0;
}

// Internal function used for fetching dispatched function calls to GML
- (double)__EXT_NATIVE__GMOperaAds_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length
{
    return __impl->__EXT_SWIFT__GMOperaAds_invocation_handler(__ret_buffer, __ret_buffer_length);
}

@end

