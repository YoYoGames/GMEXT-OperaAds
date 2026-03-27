// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName};

import java.nio.ByteBuffer;
import java.util.*;
import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.enums.*;

public abstract class GMOperaAdsInternal extends RunnerSocial implements GMOperaAdsInterface {

    private final GMExtWire.DispatchQueue __dispatch_queue = new GMExtWire.DispatchQueue();
    public double __EXT_NATIVE__GMOperaAds_invocation_handler(ByteBuffer __ret_buffer, double __ret_buffer_length)
    {
        return __dispatch_queue.fetch(__ret_buffer);
    }

    public double __EXT_NATIVE__opera_ads_init(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        boolean __result = opera_ads_init(callback);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_set_mute(double mute)
    {
        boolean __result = opera_ads_set_mute(mute != 0);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_set_gdpr(String consent_string, double applies)
    {
        opera_ads_set_gdpr(consent_string, applies != 0);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_set_us_privacy(String us_privacy)
    {
        opera_ads_set_us_privacy(us_privacy);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_set_coppa(double coppa)
    {
        opera_ads_set_coppa(coppa != 0);
        return 0;
    }

    public String __EXT_NATIVE__opera_ads_get_gdpr()
    {
        String __result = opera_ads_get_gdpr();
        return __result;
    }

    public double __EXT_NATIVE__opera_ads_get_gdpr_applies()
    {
        boolean __result = opera_ads_get_gdpr_applies();
        return __result ? 1.0 : 0.0;
    }

    public String __EXT_NATIVE__opera_ads_get_us_privacy()
    {
        String __result = opera_ads_get_us_privacy();
        return __result;
    }

    public double __EXT_NATIVE__opera_ads_get_coppa()
    {
        boolean __result = opera_ads_get_coppa();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_interstitial_set_placement_id(String placement_id)
    {
        opera_ads_interstitial_set_placement_id(placement_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_set_placement_id(String placement_id)
    {
        opera_ads_rewarded_set_placement_id(placement_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_placement_id(String placement_id)
    {
        opera_ads_rewarded_interstitial_set_placement_id(placement_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_app_open_set_placement_id(String placement_id)
    {
        opera_ads_app_open_set_placement_id(placement_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_banner_set_placement_id(String placement_id)
    {
        opera_ads_banner_set_placement_id(placement_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_interstitial_load(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_interstitial_load(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_interstitial_is_ad_valid()
    {
        boolean __result = opera_ads_interstitial_is_ad_valid();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_interstitial_show(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_interstitial_show(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_interstitial_destroy()
    {
        boolean __result = opera_ads_interstitial_destroy();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_load(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_rewarded_load(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_is_ad_valid()
    {
        boolean __result = opera_ads_rewarded_is_ad_valid();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_show(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_rewarded_show(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_destroy()
    {
        boolean __result = opera_ads_rewarded_destroy();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_load(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_rewarded_interstitial_load(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_is_ad_valid()
    {
        boolean __result = opera_ads_rewarded_interstitial_is_ad_valid();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_show(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_rewarded_interstitial_show(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_destroy()
    {
        boolean __result = opera_ads_rewarded_interstitial_destroy();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_app_open_enable(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_app_open_enable(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_app_open_disable()
    {
        boolean __result = opera_ads_app_open_disable();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_app_open_is_enabled()
    {
        boolean __result = opera_ads_app_open_is_enabled();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_load(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: callback, type: Function
        GMFunction callback = GMExtWire.readGMFunction(__arg_buffer, __dispatch_queue);

        opera_ads_banner_load(callback);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_banner_is_ad_valid()
    {
        boolean __result = opera_ads_banner_is_ad_valid();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_show(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: position, type: enum OperaAdsBannerPosition
        OperaAdsBannerPosition position = OperaAdsBannerPosition.from(GMExtWire.readI32(__arg_buffer));

        boolean __result = opera_ads_banner_show(position);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_move(ByteBuffer __arg_buffer, double __arg_buffer_length)
    {
        GMExtWire.order(__arg_buffer);

        // field: position, type: enum OperaAdsBannerPosition
        OperaAdsBannerPosition position = OperaAdsBannerPosition.from(GMExtWire.readI32(__arg_buffer));

        boolean __result = opera_ads_banner_move(position);
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_destroy()
    {
        boolean __result = opera_ads_banner_destroy();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_hide()
    {
        boolean __result = opera_ads_banner_hide();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_unhide()
    {
        boolean __result = opera_ads_banner_unhide();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_banner_is_visible()
    {
        boolean __result = opera_ads_banner_is_visible();
        return __result ? 1.0 : 0.0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_set_scene(String scene_id)
    {
        opera_ads_rewarded_set_scene(scene_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_set_reward_ssv_options(String user_id, String custom_data)
    {
        opera_ads_rewarded_set_reward_ssv_options(user_id, custom_data);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_scene(String scene_id)
    {
        opera_ads_rewarded_interstitial_set_scene(scene_id);
        return 0;
    }

    public double __EXT_NATIVE__opera_ads_rewarded_interstitial_set_reward_ssv_options(String user_id, String custom_data)
    {
        opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id, custom_data);
        return 0;
    }

}