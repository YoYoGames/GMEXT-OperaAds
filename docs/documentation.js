/**
 * @module home
 * @title Opera Ads Extension
 * @desc Welcome to the Opera Ads extension wiki!
 *
 * This extension integrates the Opera Ads SDK for GameMaker projects and supports both Android and iOS through the shared extension interface.
 *
 * The extension provides support for:
 *
 * - SDK initialization
 * - Privacy configuration (GDPR, US Privacy, COPPA)
 * - Interstitial ads
 * - Rewarded ads
 * - Rewarded interstitial ads
 * - App open ads
 * - Banner ads
 *
 * ## Notes
 *
 * - Call {func.opera_ads_init} before using any other ad function.
 * - Most ad loading and showing operations are asynchronous and use callback functions.
 * - Interstitial, rewarded, rewarded interstitial, and app open callbacks use enum event values.
 * - Rewarded formats also pass reward data when the user earns a reward.
 * - Banner ads must be loaded before they can be shown.
 * - App open ads are enabled once and are then managed automatically by the extension when the app returns to the foreground.
 *
 * Basic example of usage:
 *
 * ```gml
 * if (opera_ads_init(function(success, error_message)
 * {
 *     if (!success)
 *     {
 *         show_debug_message("Opera Ads init failed: " + string(error_message));
 *         return;
 *     }
 *
 *     show_debug_message("Opera Ads initialized");
 *
 *     opera_ads_interstitial_load(function(load_success, load_error)
 *     {
 *         if (!load_success)
 *         {
 *             show_debug_message("Interstitial load failed: " + string(load_error));
 *             return;
 *         }
 *
 *         if (opera_ads_interstitial_is_ad_valid())
 *         {
 *             opera_ads_interstitial_show(function(event, error_message)
 *             {
 *                 switch (event)
 *                 {
 *                     case OperaAdsCallbackEventInterstitial.Displayed:
 *                         show_debug_message("Interstitial displayed");
 *                     break;
 *
 *                     case OperaAdsCallbackEventInterstitial.Clicked:
 *                         show_debug_message("Interstitial clicked");
 *                     break;
 *
 *                     case OperaAdsCallbackEventInterstitial.Dismissed:
 *                         show_debug_message("Interstitial dismissed");
 *                     break;
 *
 *                     case OperaAdsCallbackEventInterstitial.Failed:
 *                         show_debug_message("Interstitial failed: " + string(error_message));
 *                     break;
 *                 }
 *             });
 *         }
 *     });
 * }))
 * {
 *     show_debug_message("Init request started");
 * }
 * ```
 *
 * @section_func
 * @ref opera_ads_init
 * @ref opera_ads_set_mute
 * @ref opera_ads_set_gdpr
 * @ref opera_ads_set_us_privacy
 * @ref opera_ads_set_coppa
 * @ref opera_ads_get_gdpr
 * @ref opera_ads_get_gdpr_applies
 * @ref opera_ads_get_us_privacy
 * @ref opera_ads_get_coppa
 * @ref opera_ads_interstitial_set_placement_id
 * @ref opera_ads_interstitial_load
 * @ref opera_ads_interstitial_is_ad_valid
 * @ref opera_ads_interstitial_show
 * @ref opera_ads_interstitial_destroy
 * @ref opera_ads_rewarded_set_placement_id
 * @ref opera_ads_rewarded_load
 * @ref opera_ads_rewarded_is_ad_valid
 * @ref opera_ads_rewarded_show
 * @ref opera_ads_rewarded_destroy
 * @ref opera_ads_rewarded_set_scene
 * @ref opera_ads_rewarded_set_reward_ssv_options
 * @ref opera_ads_rewarded_interstitial_set_placement_id
 * @ref opera_ads_rewarded_interstitial_load
 * @ref opera_ads_rewarded_interstitial_is_ad_valid
 * @ref opera_ads_rewarded_interstitial_show
 * @ref opera_ads_rewarded_interstitial_destroy
 * @ref opera_ads_rewarded_interstitial_set_scene
 * @ref opera_ads_rewarded_interstitial_set_reward_ssv_options
 * @ref opera_ads_app_open_set_placement_id
 * @ref opera_ads_app_open_enable
 * @ref opera_ads_app_open_disable
 * @ref opera_ads_app_open_is_enabled
 * @ref opera_ads_banner_set_placement_id
 * @ref opera_ads_banner_load
 * @ref opera_ads_banner_is_ad_valid
 * @ref opera_ads_banner_show
 * @ref opera_ads_banner_move
 * @ref opera_ads_banner_destroy
 * @ref opera_ads_banner_hide
 * @ref opera_ads_banner_unhide
 * @ref opera_ads_banner_is_visible
 * @section_end
 *
 * @section_const
 * @ref OperaAdsCallbackEventInterstitial
 * @ref OperaAdsCallbackEventRewarded
 * @ref OperaAdsCallbackEventRewardedInterstitial
 * @ref OperaAdsCallbackEventAppOpen
 * @ref OperaAdsCallbackEventBanner
 * @ref OperaAdsBannerPosition
 * @section_end
 *
 * @module_end
 */

/**
 * @function opera_ads_init
 * @desc Initializes the Opera Ads SDK. This should be called before using any other function in the extension. The function returns immediately and the provided callback is called asynchronously when initialization succeeds or fails.
 * @param {Function} callback
 * @returns {Bool}
 *
 * @event callback
 * @member {Bool} success Whether SDK initialization succeeded.
 * @member {String} error_message Error message when initialization fails. This argument may be omitted on success.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_init(function(success, error_message)
 * {
 *     if (!success)
 *     {
 *         show_debug_message("Init failed: " + string(error_message));
 *         return;
 *     }
 *
 *     show_debug_message("Opera Ads ready");
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_set_mute
 * @desc Enables or disables ad audio. This affects SDK audio playback after the SDK has been initialized.
 * @param {Bool} mute Whether to mute ad audio.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_set_mute(true);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_set_gdpr
 * @desc Sets the GDPR consent string and whether GDPR applies to the current user. This information should ideally be configured before calling {func.opera_ads_init}.
 * @param {String} consent_string IAB TCF consent string.
 * @param {Bool} applies Whether GDPR applies to the current user.
 * @example
 * ```gml
 * opera_ads_set_gdpr("CPXxRfAPXxRfAAHABBENBRCgAAAAAAAAAAYgAAAAAAAA", true);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_set_us_privacy
 * @desc Sets the US privacy string used by the SDK. This should typically be set before initialization when applicable.
 * @param {String} us_privacy US privacy consent string.
 * @example
 * ```gml
 * opera_ads_set_us_privacy("1YYY");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_set_coppa
 * @desc Enables or disables COPPA treatment for the current user.
 * @param {Bool} coppa
 * @example
 * ```gml
 * opera_ads_set_coppa(true);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_get_gdpr
 * @desc Returns the currently stored GDPR consent string.
 * @returns {String}
 * @example
 * ```gml
 * var consent = opera_ads_get_gdpr();
 * show_debug_message("GDPR consent: " + consent);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_get_gdpr_applies
 * @desc Returns whether GDPR currently applies for the stored privacy state.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_get_gdpr_applies())
 * {
 *     show_debug_message("GDPR applies");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_get_us_privacy
 * @desc Returns the currently stored US privacy string.
 * @returns {String}
 * @example
 * ```gml
 * show_debug_message(opera_ads_get_us_privacy());
 * ```
 * @func_end
 */

/**
 * @function opera_ads_get_coppa
 * @desc Returns whether COPPA treatment is currently enabled.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_get_coppa())
 * {
 *     show_debug_message("COPPA is enabled");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_interstitial_set_placement_id
 * @desc Sets a custom placement ID for interstitial ads. This overrides the default placement ID configured in the extension options. Must be called before loading the ad.
 * @param {String} placement_id The custom placement ID to use for interstitial ads.
 * @example
 * ```gml
 * opera_ads_interstitial_set_placement_id("your_custom_interstitial_id");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_interstitial_load
 * @desc Loads an interstitial ad asynchronously.
 * @param {Function} callback
 *
 * @event callback
 * @member {Bool} success Whether the interstitial ad loaded successfully.
 * @member {String} error_message Error message when loading fails. This argument may be omitted on success.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_interstitial_load(function(success, error_message)
 * {
 *     if (!success)
 *     {
 *         show_debug_message("Interstitial load failed: " + string(error_message));
 *         return;
 *     }
 *
 *     show_debug_message("Interstitial loaded");
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_interstitial_is_ad_valid
 * @desc Returns whether a loaded interstitial ad is currently available and still valid for showing.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_interstitial_is_ad_valid())
 * {
 *     show_debug_message("Interstitial is ready");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_interstitial_show
 * @desc Shows the currently loaded interstitial ad. The callback receives event updates during the ad lifecycle.
 * @param {Function} callback
 *
 * @event callback
 * @member {Enum.OperaAdsCallbackEventInterstitial} event Event describing the interstitial lifecycle state.
 * @member {String} error_message Error message when the event is ${const.OperaAdsCallbackEventInterstitial}.Failed. This argument may be omitted for other events.
 * @event_end
 *
 * @example
 * ```gml
 * if (opera_ads_interstitial_is_ad_valid())
 * {
 *     opera_ads_interstitial_show(function(event, error_message)
 *     {
 *         switch (event)
 *         {
 *             case OperaAdsCallbackEventInterstitial.Displayed:
 *                 show_debug_message("Interstitial displayed");
 *             break;
 *
 *             case OperaAdsCallbackEventInterstitial.Clicked:
 *                 show_debug_message("Interstitial clicked");
 *             break;
 *
 *             case OperaAdsCallbackEventInterstitial.Dismissed:
 *                 show_debug_message("Interstitial dismissed");
 *             break;
 *
 *             case OperaAdsCallbackEventInterstitial.Failed:
 *                 show_debug_message("Interstitial failed: " + string(error_message));
 *             break;
 *         }
 *     });
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_interstitial_destroy
 * @desc Destroys the currently loaded interstitial ad and clears its internal reference.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_interstitial_destroy();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_set_placement_id
 * @desc Sets a custom placement ID for rewarded ads. This overrides the default placement ID configured in the extension options. Must be called before loading the ad.
 * @param {String} placement_id The custom placement ID to use for rewarded ads.
 * @example
 * ```gml
 * opera_ads_rewarded_set_placement_id("your_custom_rewarded_id");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_load
 * @desc Loads a rewarded ad asynchronously.
 * @param {Function} callback
 *
 * @event callback
 * @member {Bool} success Whether the rewarded ad loaded successfully.
 * @member {String} error_message Error message when loading fails. This argument may be omitted on success.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_rewarded_load(function(success, error_message)
 * {
 *     if (!success)
 *     {
 *         show_debug_message("Rewarded load failed: " + string(error_message));
 *         return;
 *     }
 *
 *     show_debug_message("Rewarded loaded");
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_is_ad_valid
 * @desc Returns whether a loaded rewarded ad is currently available and still valid for showing.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_rewarded_is_ad_valid())
 * {
 *     show_debug_message("Rewarded ad ready");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_show
 * @desc Shows the currently loaded rewarded ad. The callback receives lifecycle events, and when the ad rewards the user it also receives reward data.
 * @param {Function} callback
 *
 * @event callback
 * @member {Enum.OperaAdsCallbackEventRewarded} event Event describing the rewarded ad lifecycle state.
 * @member {String} reward_type Reward type string when the event is ${const.OperaAdsCallbackEventRewarded}.Rewarded. Omitted for other events.
 * @member {Real} reward_amount Reward amount when the event is ${const.OperaAdsCallbackEventRewarded}.Rewarded. Omitted for other events.
 * @member {String} error_message Error message when the event is ${const.OperaAdsCallbackEventRewarded}.Failed. Omitted for other events.
 * @event_end
 *
 * @example
 * ```gml
 * if (opera_ads_rewarded_is_ad_valid())
 * {
 *     opera_ads_rewarded_show(function(event, reward_type, reward_amount, error_message)
 *     {
 *         switch (event)
 *         {
 *             case OperaAdsCallbackEventRewarded.Displayed:
 *                 show_debug_message("Rewarded displayed");
 *             break;
 *
 *             case OperaAdsCallbackEventRewarded.Clicked:
 *                 show_debug_message("Rewarded clicked");
 *             break;
 *
 *             case OperaAdsCallbackEventRewarded.Dismissed:
 *                 show_debug_message("Rewarded dismissed");
 *             break;
 *
 *             case OperaAdsCallbackEventRewarded.Rewarded:
 *                 show_debug_message("Reward granted: " + string(reward_type) + " / " + string(reward_amount));
 *             break;
 *
 *             case OperaAdsCallbackEventRewarded.Failed:
 *                 show_debug_message("Rewarded failed: " + string(error_message));
 *             break;
 *         }
 *     });
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_destroy
 * @desc Destroys the currently loaded rewarded ad and clears its internal reference.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_rewarded_destroy();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_set_scene
 * @desc Sets the scene ID for rewarded ads. This is used for analytics and reporting purposes. Android only.
 * @param {String} scene_id The scene identifier to associate with rewarded ads.
 * @example
 * ```gml
 * opera_ads_rewarded_set_scene("level_complete");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_set_reward_ssv_options
 * @desc Sets server-side verification (SSV) options for rewarded ads. This enables server-to-server reward validation. Android only.
 * @param {String} user_id User identifier for server-side verification.
 * @param {String} custom_data Custom data to be passed with the verification request.
 * @example
 * ```gml
 * opera_ads_rewarded_set_reward_ssv_options("user_12345", "extra_data");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_set_placement_id
 * @desc Sets a custom placement ID for rewarded interstitial ads. This overrides the default placement ID configured in the extension options. Must be called before loading the ad.
 * @param {String} placement_id The custom placement ID to use for rewarded interstitial ads.
 * @example
 * ```gml
 * opera_ads_rewarded_interstitial_set_placement_id("your_custom_rewarded_interstitial_id");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_load
 * @desc Loads a rewarded interstitial ad asynchronously.
 * @param {Function} callback
 *
 * @event callback
 * @member {Bool} success Whether the rewarded interstitial ad loaded successfully.
 * @member {String} error_message Error message when loading fails. This argument may be omitted on success.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_rewarded_interstitial_load(function(success, error_message)
 * {
 *     if (!success)
 *     {
 *         show_debug_message("Rewarded interstitial load failed: " + string(error_message));
 *         return;
 *     }
 *
 *     show_debug_message("Rewarded interstitial loaded");
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_is_ad_valid
 * @desc Returns whether a loaded rewarded interstitial ad is currently available and still valid for showing.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_rewarded_interstitial_is_ad_valid())
 * {
 *     show_debug_message("Rewarded interstitial ready");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_show
 * @desc Shows the currently loaded rewarded interstitial ad. The callback receives lifecycle events, and when the ad rewards the user it also receives reward data.
 * @param {Function} callback
 *
 * @event callback
 * @member {Enum.OperaAdsCallbackEventRewardedInterstitial} event Event describing the rewarded interstitial lifecycle state.
 * @member {String} reward_type Reward type string when the event is ${const.OperaAdsCallbackEventRewardedInterstitial}.Rewarded. Omitted for other events.
 * @member {Real} reward_amount Reward amount when the event is ${const.OperaAdsCallbackEventRewardedInterstitial}.Rewarded. Omitted for other events.
 * @member {String} error_message Error message when the event is ${const.OperaAdsCallbackEventRewardedInterstitial}.Failed. Omitted for other events.
 * @event_end
 *
 * @example
 * ```gml
 * if (opera_ads_rewarded_interstitial_is_ad_valid())
 * {
 *     opera_ads_rewarded_interstitial_show(function(event, reward_type, reward_amount, error_message)
 *     {
 *         switch (event)
 *         {
 *             case OperaAdsCallbackEventRewardedInterstitial.Displayed:
 *                 show_debug_message("Rewarded interstitial displayed");
 *             break;
 *
 *             case OperaAdsCallbackEventRewardedInterstitial.Clicked:
 *                 show_debug_message("Rewarded interstitial clicked");
 *             break;
 *
 *             case OperaAdsCallbackEventRewardedInterstitial.Dismissed:
 *                 show_debug_message("Rewarded interstitial dismissed");
 *             break;
 *
 *             case OperaAdsCallbackEventRewardedInterstitial.Rewarded:
 *                 show_debug_message("Reward granted: " + string(reward_type) + " / " + string(reward_amount));
 *             break;
 *
 *             case OperaAdsCallbackEventRewardedInterstitial.Failed:
 *                 show_debug_message("Rewarded interstitial failed: " + string(error_message));
 *             break;
 *         }
 *     });
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_destroy
 * @desc Destroys the currently loaded rewarded interstitial ad and clears its internal reference.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_rewarded_interstitial_destroy();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_set_scene
 * @desc Sets the scene ID for rewarded interstitial ads. This is used for analytics and reporting purposes. Android only.
 * @param {String} scene_id The scene identifier to associate with rewarded interstitial ads.
 * @example
 * ```gml
 * opera_ads_rewarded_interstitial_set_scene("bonus_round");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_rewarded_interstitial_set_reward_ssv_options
 * @desc Sets server-side verification (SSV) options for rewarded interstitial ads. This enables server-to-server reward validation. Android only.
 * @param {String} user_id User identifier for server-side verification.
 * @param {String} custom_data Custom data to be passed with the verification request.
 * @example
 * ```gml
 * opera_ads_rewarded_interstitial_set_reward_ssv_options("user_12345", "extra_data");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_app_open_set_placement_id
 * @desc Sets a custom placement ID for app open ads. This overrides the default placement ID configured in the extension options. Must be called before enabling app open ads.
 * @param {String} placement_id The custom placement ID to use for app open ads.
 * @example
 * ```gml
 * opera_ads_app_open_set_placement_id("your_custom_app_open_id");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_app_open_enable
 * @desc Enables app open ads. After being enabled, the extension manages app open loading and showing automatically when the application returns to the foreground.
 * @param {Function} callback
 *
 * @event callback
 * @member {Enum.OperaAdsCallbackEventAppOpen} event Event describing app open load or display state.
 * @member {String} error_message Error message when the event is ${const.OperaAdsCallbackEventAppOpen}.LoadFailed or ${const.OperaAdsCallbackEventAppOpen}.Failed. Omitted for other events.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_app_open_enable(function(event, error_message)
 * {
 *     switch (event)
 *     {
 *         case OperaAdsCallbackEventAppOpen.Loaded:
 *             show_debug_message("App open loaded");
 *         break;
 *
 *         case OperaAdsCallbackEventAppOpen.Displayed:
 *             show_debug_message("App open displayed");
 *         break;
 *
 *         case OperaAdsCallbackEventAppOpen.Dismissed:
 *             show_debug_message("App open dismissed");
 *         break;
 *
 *         case OperaAdsCallbackEventAppOpen.LoadFailed:
 *         case OperaAdsCallbackEventAppOpen.Failed:
 *             show_debug_message("App open error: " + string(error_message));
 *         break;
 *     }
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_app_open_disable
 * @desc Disables app open ads and clears any currently managed app open ad instance.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_app_open_disable();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_app_open_is_enabled
 * @desc Returns whether app open ads are currently enabled.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_app_open_is_enabled())
 * {
 *     show_debug_message("App open ads enabled");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_set_placement_id
 * @desc Sets a custom placement ID for banner ads. This overrides the default placement ID configured in the extension options. Must be called before loading the banner.
 * @param {String} placement_id The custom placement ID to use for banner ads.
 * @example
 * ```gml
 * opera_ads_banner_set_placement_id("your_custom_banner_id");
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_load
 * @desc Loads a banner ad asynchronously.
 * @param {Function} callback
 *
 * @event callback
 * @member {Enum.OperaAdsCallbackEventBanner} event Event describing banner load or interaction state.
 * @member {String} error_message Error message when the event is ${const.OperaAdsCallbackEventBanner}.LoadFailed. Omitted for other events.
 * @event_end
 *
 * @example
 * ```gml
 * opera_ads_banner_load(function(event, error_message)
 * {
 *     switch (event)
 *     {
 *         case OperaAdsCallbackEventBanner.Loaded:
 *             show_debug_message("Banner loaded");
 *         break;
 *
 *         case OperaAdsCallbackEventBanner.Impression:
 *             show_debug_message("Banner impression");
 *         break;
 *
 *         case OperaAdsCallbackEventBanner.Clicked:
 *             show_debug_message("Banner clicked");
 *         break;
 *
 *         case OperaAdsCallbackEventBanner.LoadFailed:
 *             show_debug_message("Banner load failed: " + string(error_message));
 *         break;
 *     }
 * });
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_is_ad_valid
 * @desc Returns whether a banner ad is currently loaded and still valid.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_banner_is_ad_valid())
 * {
 *     show_debug_message("Banner is valid");
 * }
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_show
 * @desc Shows the loaded banner ad at the given screen position. If the banner has already been attached, its position is updated and it is made visible.
 * @param {Enum.OperaAdsBannerPosition} position Desired banner position on screen.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_banner_show(OperaAdsBannerPosition.BottomCenter);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_move
 * @desc Moves the currently attached banner ad to a new screen position without reloading it.
 * @param {Enum.OperaAdsBannerPosition} position Desired banner position on screen.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_banner_move(OperaAdsBannerPosition.TopCenter);
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_destroy
 * @desc Destroys the current banner ad, removes it from the view hierarchy, and clears its loaded state.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_banner_destroy();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_hide
 * @desc Hides the currently attached banner ad without destroying it.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_banner_hide();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_unhide
 * @desc Makes a previously hidden banner visible again. If the banner became invalid while hidden, it may need to be loaded again.
 * @returns {Bool}
 * @example
 * ```gml
 * opera_ads_banner_unhide();
 * ```
 * @func_end
 */

/**
 * @function opera_ads_banner_is_visible
 * @desc Returns whether the banner is currently attached and visible on screen.
 * @returns {Bool}
 * @example
 * ```gml
 * if (opera_ads_banner_is_visible())
 * {
 *     show_debug_message("Banner visible");
 * }
 * ```
 * @func_end
 */

/**
 * @const OperaAdsCallbackEventInterstitial
 * @member Clicked The interstitial ad was clicked.
 * @member Displayed The interstitial ad was displayed.
 * @member Dismissed The interstitial ad was closed by the user.
 * @member Failed The interstitial ad failed to show.
 * @const_end
 */

/**
 * @const OperaAdsCallbackEventRewarded
 * @member Clicked The rewarded ad was clicked.
 * @member Displayed The rewarded ad was displayed.
 * @member Dismissed The rewarded ad was closed by the user.
 * @member Failed The rewarded ad failed to show.
 * @member Rewarded The user earned the configured reward.
 * @const_end
 */

/**
 * @const OperaAdsCallbackEventRewardedInterstitial
 * @member Clicked The rewarded interstitial ad was clicked.
 * @member Displayed The rewarded interstitial ad was displayed.
 * @member Dismissed The rewarded interstitial ad was closed by the user.
 * @member Failed The rewarded interstitial ad failed to show.
 * @member Rewarded The user earned the configured reward.
 * @const_end
 */

/**
 * @const OperaAdsCallbackEventAppOpen
 * @member Loaded An app open ad loaded successfully.
 * @member LoadFailed An app open ad failed to load.
 * @member Clicked The app open ad was clicked.
 * @member Displayed The app open ad was displayed.
 * @member Dismissed The app open ad was closed by the user.
 * @member Failed The app open ad failed to show.
 * @const_end
 */

/**
 * @const OperaAdsCallbackEventBanner
 * @member Loaded The banner ad loaded successfully.
 * @member LoadFailed The banner ad failed to load.
 * @member Impression The banner recorded an impression.
 * @member Clicked The banner ad was clicked.
 * @const_end
 */

/**
 * @const OperaAdsBannerPosition
 * @member TopLeft Positions the banner at the top-left corner.
 * @member TopCenter Positions the banner at the top-center of the screen.
 * @member TopRight Positions the banner at the top-right corner.
 * @member MiddleLeft Positions the banner at the middle-left side.
 * @member MiddleCenter Positions the banner at the center of the screen.
 * @member MiddleRight Positions the banner at the middle-right side.
 * @member BottomLeft Positions the banner at the bottom-left corner.
 * @member BottomCenter Positions the banner at the bottom-center of the screen.
 * @member BottomRight Positions the banner at the bottom-right corner.
 * @const_end
 */

/**
 * @const macros
 * @const_end
 */