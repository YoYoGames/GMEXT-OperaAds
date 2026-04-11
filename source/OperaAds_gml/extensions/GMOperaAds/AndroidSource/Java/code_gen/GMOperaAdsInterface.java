// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public interface GMOperaAdsInterface {
    public boolean opera_ads_init(GMFunction callback);
    public boolean opera_ads_is_initialized();
    public boolean opera_ads_set_mute(boolean mute);
    public void opera_ads_set_gdpr(String consent_string, boolean applies);
    public void opera_ads_set_us_privacy(String us_privacy);
    public void opera_ads_set_coppa(boolean coppa);
    public String opera_ads_get_gdpr();
    public boolean opera_ads_get_gdpr_applies();
    public String opera_ads_get_us_privacy();
    public boolean opera_ads_get_coppa();
    public void opera_ads_interstitial_set_placement_id(String placement_id);
    public void opera_ads_rewarded_set_placement_id(String placement_id);
    public void opera_ads_rewarded_interstitial_set_placement_id(String placement_id);
    public void opera_ads_app_open_set_placement_id(String placement_id);
    public void opera_ads_banner_set_placement_id(String placement_id);
    public void opera_ads_banner_set_auto_refresh(double interval);
    public void opera_ads_interstitial_load(GMFunction callback);
    public boolean opera_ads_interstitial_is_ad_valid();
    public void opera_ads_interstitial_show(GMFunction callback);
    public boolean opera_ads_interstitial_destroy();
    public void opera_ads_rewarded_load(GMFunction callback);
    public boolean opera_ads_rewarded_is_ad_valid();
    public void opera_ads_rewarded_show(GMFunction callback);
    public boolean opera_ads_rewarded_destroy();
    public void opera_ads_rewarded_interstitial_load(GMFunction callback);
    public boolean opera_ads_rewarded_interstitial_is_ad_valid();
    public void opera_ads_rewarded_interstitial_show(GMFunction callback);
    public boolean opera_ads_rewarded_interstitial_destroy();
    public void opera_ads_app_open_enable(GMFunction callback);
    public boolean opera_ads_app_open_disable();
    public boolean opera_ads_app_open_is_enabled();
    public void opera_ads_banner_load(OperaAdsBannerSize size, GMFunction callback);
    public boolean opera_ads_banner_is_ad_valid();
    public boolean opera_ads_banner_show(OperaAdsBannerPosition position);
    public boolean opera_ads_banner_move(OperaAdsBannerPosition position);
    public boolean opera_ads_banner_destroy();
    public boolean opera_ads_banner_hide();
    public boolean opera_ads_banner_unhide();
    public boolean opera_ads_banner_is_visible();
    public void opera_ads_rewarded_set_scene(String scene_id);
    public void opera_ads_rewarded_set_reward_ssv_options(String user_id, String custom_data);
    public void opera_ads_rewarded_interstitial_set_scene(String scene_id);
    public void opera_ads_rewarded_interstitial_set_reward_ssv_options(String user_id, String custom_data);
}