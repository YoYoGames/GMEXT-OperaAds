// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#include "core/GMExtUtils.h"

// Internal function used for fetching dispatched function calls to GML
GMEXPORT double __EXT_NATIVE__GMOperaAds_invocation_handler(char* __ret_buffer, double __ret_buffer_length);

GMEXPORT double __EXT_NATIVE__opera_ads_init(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_is_initialized();
GMEXPORT double __EXT_NATIVE__opera_ads_set_mute(double mute);
GMEXPORT double __EXT_NATIVE__opera_ads_set_gdpr(char* consent_string, double applies);
GMEXPORT double __EXT_NATIVE__opera_ads_set_us_privacy(char* us_privacy);
GMEXPORT double __EXT_NATIVE__opera_ads_set_coppa(double coppa);
GMEXPORT char* __EXT_NATIVE__opera_ads_get_gdpr();
GMEXPORT double __EXT_NATIVE__opera_ads_get_gdpr_applies();
GMEXPORT char* __EXT_NATIVE__opera_ads_get_us_privacy();
GMEXPORT double __EXT_NATIVE__opera_ads_get_coppa();
GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_set_placement_id(char* placement_id);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_placement_id(char* placement_id);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id(char* placement_id);
GMEXPORT double __EXT_NATIVE__opera_ads_app_open_set_placement_id(char* placement_id);
GMEXPORT double __EXT_NATIVE__opera_ads_banner_set_placement_id(char* placement_id);
GMEXPORT double __EXT_NATIVE__opera_ads_banner_set_auto_refresh(double interval);
GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_load(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_is_ad_valid();
GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_show(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_interstitial_destroy();
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_load(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_is_ad_valid();
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_show(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_destroy();
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_load(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid();
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_show(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_destroy();
GMEXPORT double __EXT_NATIVE__opera_ads_app_open_enable(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_app_open_disable();
GMEXPORT double __EXT_NATIVE__opera_ads_app_open_is_enabled();
GMEXPORT double __EXT_NATIVE__opera_ads_banner_load(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_banner_is_ad_valid();
GMEXPORT double __EXT_NATIVE__opera_ads_banner_show(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_banner_move(char* __arg_buffer, double __arg_buffer_length);
GMEXPORT double __EXT_NATIVE__opera_ads_banner_destroy();
GMEXPORT double __EXT_NATIVE__opera_ads_banner_hide();
GMEXPORT double __EXT_NATIVE__opera_ads_banner_unhide();
GMEXPORT double __EXT_NATIVE__opera_ads_banner_is_visible();
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_scene(char* scene_id);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options(char* user_id, char* custom_data);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene(char* scene_id);
GMEXPORT double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options(char* user_id, char* custom_data);

