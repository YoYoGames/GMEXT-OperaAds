// ##### extgen :: Auto-generated file do not edit!! #####

// #####################################################################
// # Macros
// #####################################################################

// #####################################################################
// # Enums
// #####################################################################

enum OperaAdsCallbackEventInterstitial
{
    Clicked = 0,
    Displayed = 1,
    Dismissed = 2,
    Failed = 3
}

enum OperaAdsCallbackEventRewarded
{
    Clicked = 0,
    Displayed = 1,
    Dismissed = 2,
    Failed = 3,
    Rewarded = 4
}

enum OperaAdsCallbackEventRewardedInterstitial
{
    Clicked = 0,
    Displayed = 1,
    Dismissed = 2,
    Failed = 3,
    Rewarded = 4
}

enum OperaAdsCallbackEventAppOpen
{
    Loaded = 0,
    LoadFailed = 1,
    Clicked = 2,
    Displayed = 3,
    Dismissed = 4,
    Failed = 5
}

enum OperaAdsCallbackEventBanner
{
    Loaded = 0,
    LoadFailed = 1,
    Impression = 2,
    Clicked = 3
}

enum OperaAdsBannerPosition
{
    TopLeft = 0,
    TopCenter = 1,
    TopRight = 2,
    MiddleLeft = 3,
    MiddleCenter = 4,
    MiddleRight = 5,
    BottomLeft = 6,
    BottomCenter = 7,
    BottomRight = 8
}

enum OperaAdsBannerSize
{
    Banner = 0,
    BannerLarge = 1,
    BannerMREC = 2,
    BannerLeaderboard = 3,
    BannerSmart = 4
}

// #####################################################################
// # Constructors
// #####################################################################

// #####################################################################
// # Codecs
// #####################################################################

// #####################################################################
// # Functions
// #####################################################################

/**
 * @param {Function} _callback
 * @returns {Bool} 
 */
function opera_ads_init(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_init(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_is_initialized (no wrapper is required)


// Skipping function opera_ads_set_mute (no wrapper is required)


// Skipping function opera_ads_set_gdpr (no wrapper is required)


// Skipping function opera_ads_set_us_privacy (no wrapper is required)


// Skipping function opera_ads_set_coppa (no wrapper is required)


// Skipping function opera_ads_get_gdpr (no wrapper is required)


// Skipping function opera_ads_get_gdpr_applies (no wrapper is required)


// Skipping function opera_ads_get_us_privacy (no wrapper is required)


// Skipping function opera_ads_get_coppa (no wrapper is required)


// Skipping function opera_ads_interstitial_set_placement_id (no wrapper is required)


// Skipping function opera_ads_rewarded_set_placement_id (no wrapper is required)


// Skipping function opera_ads_rewarded_interstitial_set_placement_id (no wrapper is required)


// Skipping function opera_ads_app_open_set_placement_id (no wrapper is required)


// Skipping function opera_ads_banner_set_placement_id (no wrapper is required)


// Skipping function opera_ads_banner_set_auto_refresh (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_interstitial_load(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_interstitial_load(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_interstitial_is_ad_valid (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_interstitial_show(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_interstitial_show(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_interstitial_destroy (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_rewarded_load(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_rewarded_load(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_rewarded_is_ad_valid (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_rewarded_show(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_rewarded_show(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_rewarded_destroy (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_rewarded_interstitial_load(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_rewarded_interstitial_load(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_rewarded_interstitial_is_ad_valid (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_rewarded_interstitial_show(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_rewarded_interstitial_show(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_rewarded_interstitial_destroy (no wrapper is required)


/**
 * @param {Function} _callback
 */
function opera_ads_app_open_enable(_callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_app_open_enable(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_app_open_disable (no wrapper is required)


// Skipping function opera_ads_app_open_is_enabled (no wrapper is required)


/**
 * @param {Enum.OperaAdsBannerSize} _size
 * @param {Function} _callback
 */
function opera_ads_banner_load(_size, _callback)
{
    static __dispatcher = __GMOperaAds_get_dispatcher();

    var __args_buffer = __ext_core_get_args_buffer();

    // param: _size, type: enum OperaAdsBannerSize

    if (!is_numeric(_size)) show_error($"{_GMFUNCTION_} :: _size expected number", true);
    buffer_write(__args_buffer, buffer_u32, _size);

    // param: _callback, type: Function
    if (!is_callable(_callback)) show_error($"{_GMFUNCTION_} :: _callback expected callable type", true);
    var _callback_handle = __ext_core_function_register(_callback, __dispatcher);
    buffer_write(__args_buffer, buffer_u64, _callback_handle);

    var _return_value = __opera_ads_banner_load(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_banner_is_ad_valid (no wrapper is required)


/**
 * @param {Enum.OperaAdsBannerPosition} _position
 * @returns {Bool} 
 */
function opera_ads_banner_show(_position)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _position, type: enum OperaAdsBannerPosition

    if (!is_numeric(_position)) show_error($"{_GMFUNCTION_} :: _position expected number", true);
    buffer_write(__args_buffer, buffer_u32, _position);

    var _return_value = __opera_ads_banner_show(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

/**
 * @param {Enum.OperaAdsBannerPosition} _position
 * @returns {Bool} 
 */
function opera_ads_banner_move(_position)
{
    var __args_buffer = __ext_core_get_args_buffer();

    // param: _position, type: enum OperaAdsBannerPosition

    if (!is_numeric(_position)) show_error($"{_GMFUNCTION_} :: _position expected number", true);
    buffer_write(__args_buffer, buffer_u32, _position);

    var _return_value = __opera_ads_banner_move(buffer_get_address(__args_buffer), buffer_tell(__args_buffer));

    return _return_value;
}

// Skipping function opera_ads_banner_destroy (no wrapper is required)


// Skipping function opera_ads_banner_hide (no wrapper is required)


// Skipping function opera_ads_banner_unhide (no wrapper is required)


// Skipping function opera_ads_banner_is_visible (no wrapper is required)


// Skipping function opera_ads_rewarded_set_scene (no wrapper is required)


// Skipping function opera_ads_rewarded_set_reward_ssv_options (no wrapper is required)


// Skipping function opera_ads_rewarded_interstitial_set_scene (no wrapper is required)


// Skipping function opera_ads_rewarded_interstitial_set_reward_ssv_options (no wrapper is required)


/// @ignore
function __GMOperaAds_get_decoders()
{
    static __decoders = [];
    return __decoders;
}
/// @ignore
function __GMOperaAds_get_dispatcher()
{
    static __dispatcher = new __GMNativeFunctionDispatcher(__GMOperaAds_invocation_handler, __GMOperaAds_get_decoders());
    return __dispatcher;
}
