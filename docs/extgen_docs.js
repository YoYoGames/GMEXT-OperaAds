/**
 * @function_partial opera_ads_init
 * @param {Function} callback
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_set_mute
 * @param {Bool} mute
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_set_gdpr
 * @param {String} consent_string
 * @param {Bool} applies
 * @function_end 
 */

/**
 * @function_partial opera_ads_set_us_privacy
 * @param {String} us_privacy
 * @function_end 
 */

/**
 * @function_partial opera_ads_set_coppa
 * @param {Bool} coppa
 * @function_end 
 */

/**
 * @function_partial opera_ads_get_gdpr
 * @returns {String} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_get_gdpr_applies
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_get_us_privacy
 * @returns {String} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_get_coppa
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_interstitial_set_placement_id
 * @param {String} placement_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_set_placement_id
 * @param {String} placement_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_set_placement_id
 * @param {String} placement_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_app_open_set_placement_id
 * @param {String} placement_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_set_placement_id
 * @param {String} placement_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_interstitial_load
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_interstitial_is_ad_valid
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_interstitial_show
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_interstitial_destroy
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_load
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_is_ad_valid
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_show
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_destroy
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_load
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_is_ad_valid
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_show
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_destroy
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_app_open_enable
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_app_open_disable
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_app_open_is_enabled
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_load
 * @param {Function} callback
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_is_ad_valid
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_show
 * @param {Enum.OperaAdsBannerPosition} position
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_move
 * @param {Enum.OperaAdsBannerPosition} position
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_destroy
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_hide
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_unhide
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_banner_is_visible
 * @returns {Bool} 
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_set_scene
 * @param {String} scene_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_set_reward_ssv_options
 * @param {String} user_id
 * @param {String} custom_data
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_set_scene
 * @param {String} scene_id
 * @function_end 
 */

/**
 * @function_partial opera_ads_rewarded_interstitial_set_reward_ssv_options
 * @param {String} user_id
 * @param {String} custom_data
 * @function_end 
 */

/**
 * @enum_partial OperaAdsCallbackEventInterstitial
 * @member Clicked
 * @member Displayed
 * @member Dismissed
 * @member Failed
 * @enum_end 
 */

/**
 * @enum_partial OperaAdsCallbackEventRewarded
 * @member Clicked
 * @member Displayed
 * @member Dismissed
 * @member Failed
 * @member Rewarded
 * @enum_end 
 */

/**
 * @enum_partial OperaAdsCallbackEventRewardedInterstitial
 * @member Clicked
 * @member Displayed
 * @member Dismissed
 * @member Failed
 * @member Rewarded
 * @enum_end 
 */

/**
 * @enum_partial OperaAdsCallbackEventAppOpen
 * @member Loaded
 * @member LoadFailed
 * @member Clicked
 * @member Displayed
 * @member Dismissed
 * @member Failed
 * @enum_end 
 */

/**
 * @enum_partial OperaAdsCallbackEventBanner
 * @member Loaded
 * @member LoadFailed
 * @member Impression
 * @member Clicked
 * @enum_end 
 */

/**
 * @enum_partial OperaAdsBannerPosition
 * @member TopLeft
 * @member TopCenter
 * @member TopRight
 * @member MiddleLeft
 * @member MiddleCenter
 * @member MiddleRight
 * @member BottomLeft
 * @member BottomCenter
 * @member BottomRight
 * @enum_end 
 */

/**
 * @const_partial macros
 * @const_end 
 */

