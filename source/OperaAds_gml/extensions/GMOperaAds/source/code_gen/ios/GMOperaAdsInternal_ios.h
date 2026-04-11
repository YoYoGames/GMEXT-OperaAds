// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#import <Foundation/Foundation.h>

@interface GMOperaAdsInternal : NSObject
- (double)__EXT_NATIVE__opera_ads_init:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_is_initialized;
- (double)__EXT_NATIVE__opera_ads_set_mute:(double)mute;
- (double)__EXT_NATIVE__opera_ads_set_gdpr:(char*)consent_string arg1:(double)applies;
- (double)__EXT_NATIVE__opera_ads_set_us_privacy:(char*)us_privacy;
- (double)__EXT_NATIVE__opera_ads_set_coppa:(double)coppa;
- (char*)__EXT_NATIVE__opera_ads_get_gdpr;
- (double)__EXT_NATIVE__opera_ads_get_gdpr_applies;
- (char*)__EXT_NATIVE__opera_ads_get_us_privacy;
- (double)__EXT_NATIVE__opera_ads_get_coppa;
- (double)__EXT_NATIVE__opera_ads_interstitial_set_placement_id:(char*)placement_id;
- (double)__EXT_NATIVE__opera_ads_rewarded_set_placement_id:(char*)placement_id;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id:(char*)placement_id;
- (double)__EXT_NATIVE__opera_ads_app_open_set_placement_id:(char*)placement_id;
- (double)__EXT_NATIVE__opera_ads_banner_set_placement_id:(char*)placement_id;
- (double)__EXT_NATIVE__opera_ads_banner_set_auto_refresh:(double)interval;
- (double)__EXT_NATIVE__opera_ads_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_interstitial_is_ad_valid;
- (double)__EXT_NATIVE__opera_ads_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_interstitial_destroy;
- (double)__EXT_NATIVE__opera_ads_rewarded_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_rewarded_is_ad_valid;
- (double)__EXT_NATIVE__opera_ads_rewarded_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_rewarded_destroy;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_destroy;
- (double)__EXT_NATIVE__opera_ads_app_open_enable:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_app_open_disable;
- (double)__EXT_NATIVE__opera_ads_app_open_is_enabled;
- (double)__EXT_NATIVE__opera_ads_banner_load:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_banner_is_ad_valid;
- (double)__EXT_NATIVE__opera_ads_banner_show:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_banner_move:(char*)__arg_buffer arg1:(double)__arg_buffer_length;
- (double)__EXT_NATIVE__opera_ads_banner_destroy;
- (double)__EXT_NATIVE__opera_ads_banner_hide;
- (double)__EXT_NATIVE__opera_ads_banner_unhide;
- (double)__EXT_NATIVE__opera_ads_banner_is_visible;
- (double)__EXT_NATIVE__opera_ads_rewarded_set_scene:(char*)scene_id;
- (double)__EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene:(char*)scene_id;
- (double)__EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options:(char*)user_id arg1:(char*)custom_data;
- (double)__EXT_NATIVE__GMOperaAds_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length;
@end


