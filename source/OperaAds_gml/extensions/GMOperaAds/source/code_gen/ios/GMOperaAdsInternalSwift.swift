import Foundation
import os.log
import CxxStdlib

open class GMOperaAdsInternalSwift
{
    internal var __dispatch_queue: GMDispatchQueue = GMDispatchQueue()

    public init()
    {
    }

    open func opera_ads_init(callback: GMFunction) -> Bool
    {
        // default stub for opera_ads_init
        return false
    }

    open func opera_ads_is_initialized() -> Bool
    {
        // default stub for opera_ads_is_initialized
        return false
    }

    open func opera_ads_set_mute(mute: Bool) -> Bool
    {
        // default stub for opera_ads_set_mute
        return false
    }

    open func opera_ads_set_gdpr(consent_string: String, applies: Bool)
    {
        // default stub for opera_ads_set_gdpr
    }

    open func opera_ads_set_us_privacy(us_privacy: String)
    {
        // default stub for opera_ads_set_us_privacy
    }

    open func opera_ads_set_coppa(coppa: Bool)
    {
        // default stub for opera_ads_set_coppa
    }

    open func opera_ads_get_gdpr() -> String
    {
        // default stub for opera_ads_get_gdpr
        return ""
    }

    open func opera_ads_get_gdpr_applies() -> Bool
    {
        // default stub for opera_ads_get_gdpr_applies
        return false
    }

    open func opera_ads_get_us_privacy() -> String
    {
        // default stub for opera_ads_get_us_privacy
        return ""
    }

    open func opera_ads_get_coppa() -> Bool
    {
        // default stub for opera_ads_get_coppa
        return false
    }

    open func opera_ads_interstitial_set_placement_id(placement_id: String)
    {
        // default stub for opera_ads_interstitial_set_placement_id
    }

    open func opera_ads_rewarded_set_placement_id(placement_id: String)
    {
        // default stub for opera_ads_rewarded_set_placement_id
    }

    open func opera_ads_rewarded_interstitial_set_placement_id(placement_id: String)
    {
        // default stub for opera_ads_rewarded_interstitial_set_placement_id
    }

    open func opera_ads_app_open_set_placement_id(placement_id: String)
    {
        // default stub for opera_ads_app_open_set_placement_id
    }

    open func opera_ads_banner_set_placement_id(placement_id: String)
    {
        // default stub for opera_ads_banner_set_placement_id
    }

    open func opera_ads_banner_set_auto_refresh(interval: Double)
    {
        // default stub for opera_ads_banner_set_auto_refresh
    }

    open func opera_ads_interstitial_load(callback: GMFunction)
    {
        // default stub for opera_ads_interstitial_load
    }

    open func opera_ads_interstitial_is_ad_valid() -> Bool
    {
        // default stub for opera_ads_interstitial_is_ad_valid
        return false
    }

    open func opera_ads_interstitial_show(callback: GMFunction)
    {
        // default stub for opera_ads_interstitial_show
    }

    open func opera_ads_interstitial_destroy() -> Bool
    {
        // default stub for opera_ads_interstitial_destroy
        return false
    }

    open func opera_ads_rewarded_load(callback: GMFunction)
    {
        // default stub for opera_ads_rewarded_load
    }

    open func opera_ads_rewarded_is_ad_valid() -> Bool
    {
        // default stub for opera_ads_rewarded_is_ad_valid
        return false
    }

    open func opera_ads_rewarded_show(callback: GMFunction)
    {
        // default stub for opera_ads_rewarded_show
    }

    open func opera_ads_rewarded_destroy() -> Bool
    {
        // default stub for opera_ads_rewarded_destroy
        return false
    }

    open func opera_ads_rewarded_interstitial_load(callback: GMFunction)
    {
        // default stub for opera_ads_rewarded_interstitial_load
    }

    open func opera_ads_rewarded_interstitial_is_ad_valid() -> Bool
    {
        // default stub for opera_ads_rewarded_interstitial_is_ad_valid
        return false
    }

    open func opera_ads_rewarded_interstitial_show(callback: GMFunction)
    {
        // default stub for opera_ads_rewarded_interstitial_show
    }

    open func opera_ads_rewarded_interstitial_destroy() -> Bool
    {
        // default stub for opera_ads_rewarded_interstitial_destroy
        return false
    }

    open func opera_ads_app_open_enable(callback: GMFunction)
    {
        // default stub for opera_ads_app_open_enable
    }

    open func opera_ads_app_open_disable() -> Bool
    {
        // default stub for opera_ads_app_open_disable
        return false
    }

    open func opera_ads_app_open_is_enabled() -> Bool
    {
        // default stub for opera_ads_app_open_is_enabled
        return false
    }

    open func opera_ads_banner_load(size: OperaAdsBannerSize, callback: GMFunction)
    {
        // default stub for opera_ads_banner_load
    }

    open func opera_ads_banner_is_ad_valid() -> Bool
    {
        // default stub for opera_ads_banner_is_ad_valid
        return false
    }

    open func opera_ads_banner_show(position: OperaAdsBannerPosition) -> Bool
    {
        // default stub for opera_ads_banner_show
        return false
    }

    open func opera_ads_banner_move(position: OperaAdsBannerPosition) -> Bool
    {
        // default stub for opera_ads_banner_move
        return false
    }

    open func opera_ads_banner_destroy() -> Bool
    {
        // default stub for opera_ads_banner_destroy
        return false
    }

    open func opera_ads_banner_hide() -> Bool
    {
        // default stub for opera_ads_banner_hide
        return false
    }

    open func opera_ads_banner_unhide() -> Bool
    {
        // default stub for opera_ads_banner_unhide
        return false
    }

    open func opera_ads_banner_is_visible() -> Bool
    {
        // default stub for opera_ads_banner_is_visible
        return false
    }

    open func opera_ads_rewarded_set_scene(scene_id: String)
    {
        // default stub for opera_ads_rewarded_set_scene
    }

    open func opera_ads_rewarded_set_reward_ssv_options(user_id: String, custom_data: String)
    {
        // default stub for opera_ads_rewarded_set_reward_ssv_options
    }

    open func opera_ads_rewarded_interstitial_set_scene(scene_id: String)
    {
        // default stub for opera_ads_rewarded_interstitial_set_scene
    }

    open func opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id: String, custom_data: String)
    {
        // default stub for opera_ads_rewarded_interstitial_set_reward_ssv_options
    }

    public func __EXT_SWIFT__opera_ads_init(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            let __result = self.opera_ads_init(callback: callback)
            return __result ? 1.0 : 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_init'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_is_initialized() -> Double
    {
        let __result = self.opera_ads_is_initialized()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_set_mute(_ mute: Double) -> Double
    {
        let __result = self.opera_ads_set_mute(mute: mute != 0)
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_set_gdpr(_ consent_string: String, arg1 applies: Double) -> Double
    {
        self.opera_ads_set_gdpr(consent_string: consent_string, applies: applies != 0)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_set_us_privacy(_ us_privacy: String) -> Double
    {
        self.opera_ads_set_us_privacy(us_privacy: us_privacy)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_set_coppa(_ coppa: Double) -> Double
    {
        self.opera_ads_set_coppa(coppa: coppa != 0)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_get_gdpr() -> String
    {
        let __result = self.opera_ads_get_gdpr()
        return __result
    }

    public func __EXT_SWIFT__opera_ads_get_gdpr_applies() -> Double
    {
        let __result = self.opera_ads_get_gdpr_applies()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_get_us_privacy() -> String
    {
        let __result = self.opera_ads_get_us_privacy()
        return __result
    }

    public func __EXT_SWIFT__opera_ads_get_coppa() -> Double
    {
        let __result = self.opera_ads_get_coppa()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_interstitial_set_placement_id(_ placement_id: String) -> Double
    {
        self.opera_ads_interstitial_set_placement_id(placement_id: placement_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_set_placement_id(_ placement_id: String) -> Double
    {
        self.opera_ads_rewarded_set_placement_id(placement_id: placement_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_set_placement_id(_ placement_id: String) -> Double
    {
        self.opera_ads_rewarded_interstitial_set_placement_id(placement_id: placement_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_app_open_set_placement_id(_ placement_id: String) -> Double
    {
        self.opera_ads_app_open_set_placement_id(placement_id: placement_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_set_placement_id(_ placement_id: String) -> Double
    {
        self.opera_ads_banner_set_placement_id(placement_id: placement_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_set_auto_refresh(_ interval: Double) -> Double
    {
        self.opera_ads_banner_set_auto_refresh(interval: Double(interval))
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_interstitial_load(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_interstitial_load(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_interstitial_load'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_interstitial_is_ad_valid() -> Double
    {
        let __result = self.opera_ads_interstitial_is_ad_valid()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_interstitial_show(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_interstitial_show(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_interstitial_show'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_interstitial_destroy() -> Double
    {
        let __result = self.opera_ads_interstitial_destroy()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_load(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_rewarded_load(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_rewarded_load'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_rewarded_is_ad_valid() -> Double
    {
        let __result = self.opera_ads_rewarded_is_ad_valid()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_show(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_rewarded_show(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_rewarded_show'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_rewarded_destroy() -> Double
    {
        let __result = self.opera_ads_rewarded_destroy()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_load(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_rewarded_interstitial_load(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_rewarded_interstitial_load'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_is_ad_valid() -> Double
    {
        let __result = self.opera_ads_rewarded_interstitial_is_ad_valid()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_show(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_rewarded_interstitial_show(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_rewarded_interstitial_show'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_destroy() -> Double
    {
        let __result = self.opera_ads_rewarded_interstitial_destroy()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_app_open_enable(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_app_open_enable(callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_app_open_enable'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_app_open_disable() -> Double
    {
        let __result = self.opera_ads_app_open_disable()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_app_open_is_enabled() -> Double
    {
        let __result = self.opera_ads_app_open_is_enabled()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_load(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: size, type: enum OperaAdsBannerSize
            let size: OperaAdsBannerSize = (OperaAdsBannerSize(rawValue: try __br.readRaw(UInt32.self))!)

            // field: callback, type: Function
            let callback: GMFunction = try __br.readGMFunction(__dispatch_queue)

            self.opera_ads_banner_load(size: size, callback: callback)
            return 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_banner_load'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_banner_is_ad_valid() -> Double
    {
        let __result = self.opera_ads_banner_is_ad_valid()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_show(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: position, type: enum OperaAdsBannerPosition
            let position: OperaAdsBannerPosition = (OperaAdsBannerPosition(rawValue: try __br.readRaw(UInt32.self))!)

            let __result = self.opera_ads_banner_show(position: position)
            return __result ? 1.0 : 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_banner_show'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_banner_move(_ __arg_buffer: UnsafeMutablePointer<CChar>?, arg1 __arg_buffer_length: Double) -> Double
    {
        do
        {
            var __br = BufferReader(base: UnsafeRawPointer(__arg_buffer!), size: Int(__arg_buffer_length))

            // field: position, type: enum OperaAdsBannerPosition
            let position: OperaAdsBannerPosition = (OperaAdsBannerPosition(rawValue: try __br.readRaw(UInt32.self))!)

            let __result = self.opera_ads_banner_move(position: position)
            return __result ? 1.0 : 0.0
        }
        catch
        {
            os_log("Corrupted buffer when calling 'opera_ads_banner_move'", log: .default, type: .error)
            return -1
        }
    }

    public func __EXT_SWIFT__opera_ads_banner_destroy() -> Double
    {
        let __result = self.opera_ads_banner_destroy()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_hide() -> Double
    {
        let __result = self.opera_ads_banner_hide()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_unhide() -> Double
    {
        let __result = self.opera_ads_banner_unhide()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_banner_is_visible() -> Double
    {
        let __result = self.opera_ads_banner_is_visible()
        return __result ? 1.0 : 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_set_scene(_ scene_id: String) -> Double
    {
        self.opera_ads_rewarded_set_scene(scene_id: scene_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_set_reward_ssv_options(_ user_id: String, arg1 custom_data: String) -> Double
    {
        self.opera_ads_rewarded_set_reward_ssv_options(user_id: user_id, custom_data: custom_data)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_set_scene(_ scene_id: String) -> Double
    {
        self.opera_ads_rewarded_interstitial_set_scene(scene_id: scene_id)
        return 0.0
    }

    public func __EXT_SWIFT__opera_ads_rewarded_interstitial_set_reward_ssv_options(_ user_id: String, arg1 custom_data: String) -> Double
    {
        self.opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id: user_id, custom_data: custom_data)
        return 0.0
    }

    public func __EXT_SWIFT__GMOperaAds_invocation_handler(_ __ret_buffer: UnsafeMutablePointer<CChar>?, arg1 __ret_buffer_length: Double) -> Double
    {
        var __bw = BufferWriter(base: UnsafeMutableRawPointer(__ret_buffer!), size: Int(__ret_buffer_length))
        return __dispatch_queue.fetch(into: &__bw)
    }

}
