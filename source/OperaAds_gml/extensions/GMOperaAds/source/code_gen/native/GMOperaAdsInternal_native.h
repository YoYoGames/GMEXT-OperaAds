// ##### extgen :: Auto-generated file do not edit!! #####

#pragma once
#include <cstdint>
#include <string_view>
#include <vector>
#include <array>
#include <optional>
#include "core/GMExtWire.h"

namespace gm_consts
{
}


namespace gm_enums
{
    enum class OperaAdsCallbackEventInterstitial : std::uint32_t
    {
        Clicked = 0,
        Displayed = 1,
        Dismissed = 2,
        Failed = 3
    };

    enum class OperaAdsCallbackEventRewarded : std::uint32_t
    {
        Clicked = 0,
        Displayed = 1,
        Dismissed = 2,
        Failed = 3,
        Rewarded = 4
    };

    enum class OperaAdsCallbackEventRewardedInterstitial : std::uint32_t
    {
        Clicked = 0,
        Displayed = 1,
        Dismissed = 2,
        Failed = 3,
        Rewarded = 4
    };

    enum class OperaAdsCallbackEventAppOpen : std::uint32_t
    {
        Loaded = 0,
        LoadFailed = 1,
        Clicked = 2,
        Displayed = 3,
        Dismissed = 4,
        Failed = 5
    };

    enum class OperaAdsCallbackEventBanner : std::uint32_t
    {
        Loaded = 0,
        LoadFailed = 1,
        Impression = 2,
        Clicked = 3
    };

    enum class OperaAdsBannerPosition : std::uint32_t
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
    };

}


namespace gm_structs
{

}

namespace gm::wire::codec
{
}

namespace gm::wire::details
{
}

bool opera_ads_init(const gm::wire::GMFunction& callback);
bool opera_ads_set_mute(bool mute);
void opera_ads_set_gdpr(std::string_view consent_string, bool applies);
void opera_ads_set_us_privacy(std::string_view us_privacy);
void opera_ads_set_coppa(bool coppa);
std::string opera_ads_get_gdpr();
bool opera_ads_get_gdpr_applies();
std::string opera_ads_get_us_privacy();
bool opera_ads_get_coppa();
void opera_ads_interstitial_set_placement_id(std::string_view placement_id);
void opera_ads_rewarded_set_placement_id(std::string_view placement_id);
void opera_ads_rewarded_interstitial_set_placement_id(std::string_view placement_id);
void opera_ads_app_open_set_placement_id(std::string_view placement_id);
void opera_ads_banner_set_placement_id(std::string_view placement_id);
void opera_ads_interstitial_load(const gm::wire::GMFunction& callback);
bool opera_ads_interstitial_is_ad_valid();
void opera_ads_interstitial_show(const gm::wire::GMFunction& callback);
bool opera_ads_interstitial_destroy();
void opera_ads_rewarded_load(const gm::wire::GMFunction& callback);
bool opera_ads_rewarded_is_ad_valid();
void opera_ads_rewarded_show(const gm::wire::GMFunction& callback);
bool opera_ads_rewarded_destroy();
void opera_ads_rewarded_interstitial_load(const gm::wire::GMFunction& callback);
bool opera_ads_rewarded_interstitial_is_ad_valid();
void opera_ads_rewarded_interstitial_show(const gm::wire::GMFunction& callback);
bool opera_ads_rewarded_interstitial_destroy();
void opera_ads_app_open_enable(const gm::wire::GMFunction& callback);
bool opera_ads_app_open_disable();
bool opera_ads_app_open_is_enabled();
void opera_ads_banner_load(const gm::wire::GMFunction& callback);
bool opera_ads_banner_is_ad_valid();
bool opera_ads_banner_show(gm_enums::OperaAdsBannerPosition position);
bool opera_ads_banner_move(gm_enums::OperaAdsBannerPosition position);
bool opera_ads_banner_destroy();
bool opera_ads_banner_hide();
bool opera_ads_banner_unhide();
bool opera_ads_banner_is_visible();
void opera_ads_rewarded_set_scene(std::string_view scene_id);
void opera_ads_rewarded_set_reward_ssv_options(std::string_view user_id, std::string_view custom_data);
void opera_ads_rewarded_interstitial_set_scene(std::string_view scene_id);
void opera_ads_rewarded_interstitial_set_reward_ssv_options(std::string_view user_id, std::string_view custom_data);
