// ##### extgen :: Auto-generated file do not edit!! #####

#include "GMOperaAdsInternal_native.h"
#include "GMOperaAdsInternal_exports.h"

using namespace gm_structs;
using namespace gm::wire::codec;

static gm::runtime::DispatchQueue __dispatch_queue;

// Internal function used for fetching dispatched function calls to GML
GMEXPORT double __EXT_NATIVE__GMOperaAds_invocation_handler(char* __ret_buffer, double __ret_buffer_length)
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

GMEXPORT double __EXT_NATIVE__opera_ads_init(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    auto&& __result = opera_ads_init(callback);
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_is_initialized()
{
    auto&& __result = opera_ads_is_initialized();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_set_mute(double mute)
{
    auto&& __result = opera_ads_set_mute(static_cast<bool>(mute));
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_set_gdpr(char* consent_string, double applies)
{
    opera_ads_set_gdpr(consent_string, static_cast<bool>(applies));
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_set_us_privacy(char* us_privacy)
{
    opera_ads_set_us_privacy(us_privacy);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_set_coppa(double coppa)
{
    opera_ads_set_coppa(static_cast<bool>(coppa));
    return 0;
}

GMEXPORT char* __EXT_NATIVE__opera_ads_get_gdpr()
{
    static std::string __result;
    __result = opera_ads_get_gdpr();
    return (char*)__result.c_str();
}

GMEXPORT double __EXT_NATIVE__opera_ads_get_gdpr_applies()
{
    auto&& __result = opera_ads_get_gdpr_applies();
    return static_cast<double>(__result);
}

GMEXPORT char* __EXT_NATIVE__opera_ads_get_us_privacy()
{
    static std::string __result;
    __result = opera_ads_get_us_privacy();
    return (char*)__result.c_str();
}

GMEXPORT double __EXT_NATIVE__opera_ads_get_coppa()
{
    auto&& __result = opera_ads_get_coppa();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_set_placement_id(char* placement_id)
{
    opera_ads_interstitial_set_placement_id(placement_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_placement_id(char* placement_id)
{
    opera_ads_rewarded_set_placement_id(placement_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id(char* placement_id)
{
    opera_ads_rewarded_interstitial_set_placement_id(placement_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_app_open_set_placement_id(char* placement_id)
{
    opera_ads_app_open_set_placement_id(placement_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_set_placement_id(char* placement_id)
{
    opera_ads_banner_set_placement_id(placement_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_set_auto_refresh(double interval)
{
    opera_ads_banner_set_auto_refresh(static_cast<double>(interval));
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_load(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_interstitial_load(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_is_ad_valid()
{
    auto&& __result = opera_ads_interstitial_is_ad_valid();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_show(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_interstitial_show(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_destroy()
{
    auto&& __result = opera_ads_interstitial_destroy();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_load(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_rewarded_load(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_is_ad_valid()
{
    auto&& __result = opera_ads_rewarded_is_ad_valid();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_show(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_rewarded_show(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_destroy()
{
    auto&& __result = opera_ads_rewarded_destroy();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_load(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_rewarded_interstitial_load(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid()
{
    auto&& __result = opera_ads_rewarded_interstitial_is_ad_valid();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_show(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_rewarded_interstitial_show(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_destroy()
{
    auto&& __result = opera_ads_rewarded_interstitial_destroy();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_app_open_enable(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_app_open_enable(callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_app_open_disable()
{
    auto&& __result = opera_ads_app_open_disable();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_app_open_is_enabled()
{
    auto&& __result = opera_ads_app_open_is_enabled();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_load(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: size, type: enum OperaAdsBannerSize
    gm_enums::OperaAdsBannerSize size = gm::wire::codec::readValue<gm_enums::OperaAdsBannerSize>(__br);

    // field: callback, type: Function
    gm::wire::GMFunction callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);

    opera_ads_banner_load(size, callback);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_is_ad_valid()
{
    auto&& __result = opera_ads_banner_is_ad_valid();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_show(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: position, type: enum OperaAdsBannerPosition
    gm_enums::OperaAdsBannerPosition position = gm::wire::codec::readValue<gm_enums::OperaAdsBannerPosition>(__br);

    auto&& __result = opera_ads_banner_show(position);
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_move(char* __arg_buffer, double __arg_buffer_length)
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: position, type: enum OperaAdsBannerPosition
    gm_enums::OperaAdsBannerPosition position = gm::wire::codec::readValue<gm_enums::OperaAdsBannerPosition>(__br);

    auto&& __result = opera_ads_banner_move(position);
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_destroy()
{
    auto&& __result = opera_ads_banner_destroy();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_hide()
{
    auto&& __result = opera_ads_banner_hide();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_unhide()
{
    auto&& __result = opera_ads_banner_unhide();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_banner_is_visible()
{
    auto&& __result = opera_ads_banner_is_visible();
    return static_cast<double>(__result);
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_scene(char* scene_id)
{
    opera_ads_rewarded_set_scene(scene_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options(char* user_id, char* custom_data)
{
    opera_ads_rewarded_set_reward_ssv_options(user_id, custom_data);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene(char* scene_id)
{
    opera_ads_rewarded_interstitial_set_scene(scene_id);
    return 0;
}

GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options(char* user_id, char* custom_data)
{
    opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id, custom_data);
    return 0;
}

