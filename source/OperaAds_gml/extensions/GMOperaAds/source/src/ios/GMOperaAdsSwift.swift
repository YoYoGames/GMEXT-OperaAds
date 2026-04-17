import Foundation
import UIKit
import CxxStdlib
import OpAdxSdk

@_silgen_name("extOptGetString")
private func extOptGetString(_ ext: UnsafeMutablePointer<CChar>?, _ opt: UnsafeMutablePointer<CChar>?) -> UnsafePointer<CChar>?

@_silgen_name("GMOperaAds_getGLView")
private func getGLView() -> UIView?

public class GMOperaAdsSwift: GMOperaAdsInternalSwift {
    private let notInitializedError = "Opera Ads SDK is not initialized."

    private var operaAdsInitialized = false
    private var operaAdsDisplayingAd = false

    private var publisherName = ""

    private var gdprConsentString = ""
    private var gdprApplies = false
    private var usPrivacyString = ""
    private var coppa = false

    private var interstitialPlacementId = ""
    private var rewardedPlacementId = ""
    private var rewardedInterstitialPlacementId = ""
    private var appOpenPlacementId = ""
    private var bannerPlacementId = ""
    private var openAdsPlacementIdActive = ""

    private var interstitialAd: OpAdxInterstitialAd?
    private var rewardedAd: OpAdxRewardedAd?
    private var rewardedInterstitialAd: OpAdxRewardedInterstitialAd?
    private var appOpenAd: OpAdxAppOpenAd?
    private var bannerAdView: OpAdxBannerAdView?

    private var bannerWrapper: UIView?
    private var bannerPosition: OperaAdsBannerPosition = .TopCenter
    private var bannerSize: OperaAdsBannerSize = .BannerMREC
    private var bannerAutoRefreshInterval: Int = 0
    private var bannerAdded = false
    private var bannerVisible = false
    private var bannerLoaded = false
    private var bannerLoadedOnce = false
    private var bannerLoadInProgress = false

    private var interstitialLoadCallback: GMFunction?
    private var interstitialShowCallback: GMFunction?
    private var rewardedLoadCallback: GMFunction?
    private var rewardedShowCallback: GMFunction?
    private var rewardedInterstitialLoadCallback: GMFunction?
    private var rewardedInterstitialShowCallback: GMFunction?
    private var appOpenCallback: GMFunction?
    private var bannerLoadCallback: GMFunction?

    private var interstitialLoadListener: OpAdxInterstitialAdLoadListenerImp?
    private var interstitialShowListener: OpAdxInterstitialAdInteractionListenerImp?
    private var rewardedLoadListener: OpAdxRewardedAdLoadListenerImp?
    private var rewardedShowListener: OpAdxRewardedAdInteractionListenerImp?
    private var rewardedInterstitialLoadListener: OpAdxRewardedInterstitialAdLoadListenerImp?
    private var rewardedInterstitialShowListener: OpAdxRewardedInterstitialAdInteractionListenerImp?
    private var appOpenLoadListener: OpAdxAppOpenAdLoadListenerImp?
    private var appOpenShowListener: OpAdxAppOpenAdInteractionListenerImp?
    private var bannerListener: OpAdxBannerAdListenerImp?

    private var rewardedSceneId: String?
    private var rewardedSSVUserId: String?
    private var rewardedSSVCustomData: String?
    private var rewardedInterstitialSceneId: String?
    private var rewardedInterstitialSSVUserId: String?
    private var rewardedInterstitialSSVCustomData: String?

    public override init() {
        super.init()
    }

    public override func opera_ads_init(callback: GMFunction) -> Bool {
        let applicationId = extensionOption(ext: "GMOperaAds", opt: "iOS Application Id")
        let iOSAppId = extensionOption(ext: "GMOperaAds", opt: "iOS App Id")
        if publisherName.isEmpty { publisherName = extensionOption(ext: "GMOperaAds", opt: "iOS Publisher Name") }

        if interstitialPlacementId.isEmpty { interstitialPlacementId = extensionOption(ext: "GMOperaAds", opt: "iOS Interstitial") }
        if rewardedPlacementId.isEmpty { rewardedPlacementId = extensionOption(ext: "GMOperaAds", opt: "iOS Rewarded") }
        if rewardedInterstitialPlacementId.isEmpty { rewardedInterstitialPlacementId = extensionOption(ext: "GMOperaAds", opt: "iOS Rewarded Interstitial") }
        if appOpenPlacementId.isEmpty { appOpenPlacementId = extensionOption(ext: "GMOperaAds", opt: "iOS App Open") }
        if bannerPlacementId.isEmpty { bannerPlacementId = extensionOption(ext: "GMOperaAds", opt: "iOS Banner") }

        bannerWrapper = nil
        bannerPosition = .TopCenter
        bannerSize = .BannerMREC
        bannerAdded = false
        bannerVisible = false
        bannerLoaded = false
        bannerLoadedOnce = false
        bannerLoadInProgress = false

        var builder = OpAdxSdkInitConfig.Builder(applicationId: applicationId)
            .iOSAppId(iOSAppId)
            .coppa(coppa)
            .publisherName(publisherName)

        if !usPrivacyString.isEmpty {
            builder = builder.usPrivacy(usPrivacyString)
        }

        let config = builder.build()

        OpAdxSDK.initialize(
            withConfig: config,
            onSuccess: { [self] in
                self.operaAdsInitialized = true
                callback.call(true)
            },
            onError: { error in
                callback.call(false, error.localizedDescription)
            }
        )

        return true
    }

    public override func opera_ads_is_initialized() -> Bool {
        operaAdsInitialized
    }

    public override func opera_ads_set_mute(mute: Bool) -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_set_mute :: SDK is not initialized.")
            return false
        }

        OpAdxSdkCore.setOpAdxSdkMuted(NSNumber(value: mute ? 1 : 0))
        
        return true
    }

    public override func opera_ads_set_gdpr(consent_string: String, applies: Bool) {
        gdprConsentString = consent_string
        gdprApplies = applies
        applyPrivacyOptions()
    }

    public override func opera_ads_set_us_privacy(us_privacy: String) {
        usPrivacyString = us_privacy
        applyPrivacyOptions()
    }

    public override func opera_ads_set_coppa(coppa: Bool) {
        self.coppa = coppa
        applyPrivacyOptions()
    }

    public override func opera_ads_set_publisher_name(publisher_name: String) {
        publisherName = publisher_name
    }

    public override func opera_ads_get_gdpr() -> String {
        gdprConsentString
    }

    public override func opera_ads_get_gdpr_applies() -> Bool {
        gdprApplies
    }

    public override func opera_ads_get_us_privacy() -> String {
        usPrivacyString
    }

    public override func opera_ads_get_coppa() -> Bool {
        coppa
    }

    public override func opera_ads_interstitial_set_placement_id(placement_id: String) {
        interstitialPlacementId = placement_id
    }

    public override func opera_ads_rewarded_set_placement_id(placement_id: String) {
        rewardedPlacementId = placement_id
    }

    public override func opera_ads_rewarded_interstitial_set_placement_id(placement_id: String) {
        rewardedInterstitialPlacementId = placement_id
    }

    public override func opera_ads_app_open_set_placement_id(placement_id: String) {
        appOpenPlacementId = placement_id
        openAdsPlacementIdActive = placement_id
        if appOpenAd != nil {
            opera_ads_app_open_destroyInternal()
        }
    }

    public override func opera_ads_banner_set_placement_id(placement_id: String) {
        bannerPlacementId = placement_id
    }

    public override func opera_ads_banner_set_auto_refresh(interval: Double) {
        bannerAutoRefreshInterval = Int(interval)
        bannerAdView?.setAutoRefreshInterval(bannerAutoRefreshInterval)
    }

    public override func opera_ads_interstitial_load(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(false, notInitializedError)
            return
        }

        guard !interstitialPlacementId.isEmpty else {
            callback.call(false, "Interstitial placement ID is empty.")
            return
        }

        interstitialLoadCallback = callback
        interstitialAd = OpAdxInterstitialAd(placementId: interstitialPlacementId, auctionType: .regular)

        let loadListener = OpAdxInterstitialAdLoadListenerImp(
            onAdLoaded: { [self] _ in
                self.interstitialLoadCallback?.call(true)
            },
            onAdFailedToLoad: { [self] error in
                self.interstitialLoadCallback?.call(false, error.message)
            }
        )
        interstitialLoadListener = loadListener
        interstitialAd?.load(placementId: interstitialPlacementId, listener: loadListener)
    }

    public override func opera_ads_interstitial_is_ad_valid() -> Bool {
        guard operaAdsInitialized else { return false }
        guard let ad = interstitialAd else { return false }
        return !ad.isAdInvalidated()
    }

    public override func opera_ads_interstitial_show(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(OperaAdsCallbackEventInterstitial.Failed.rawValue, notInitializedError)
            return
        }

        guard let ad = interstitialAd else {
            callback.call(OperaAdsCallbackEventInterstitial.Failed.rawValue, "Interstitial ad is not loaded.")
            return
        }

        guard !ad.isAdInvalidated() else {
            _ = opera_ads_interstitial_destroy()
            callback.call(OperaAdsCallbackEventInterstitial.Failed.rawValue, "Interstitial ad is invalid.")
            return
        }

        guard let rootVC = rootViewController() else {
            callback.call(OperaAdsCallbackEventInterstitial.Failed.rawValue, "Could not resolve a root view controller.")
            return
        }

        operaAdsDisplayingAd = true
        interstitialShowCallback = callback

        let showListener = OpAdxInterstitialAdInteractionListenerImp(
            onAdClicked: { [self] in
                self.interstitialShowCallback?.call(OperaAdsCallbackEventInterstitial.Clicked.rawValue)
            },
            onAdDisplayed: { [self] in
                self.interstitialShowCallback?.call(OperaAdsCallbackEventInterstitial.Displayed.rawValue)
            },
            onAdDismissed: { [self] in
                self.interstitialShowCallback?.call(OperaAdsCallbackEventInterstitial.Dismissed.rawValue)
                self.interstitialAd = nil
                self.operaAdsDisplayingAd = false
            },
            onAdFailedToShow: { [self] error in
                self.operaAdsDisplayingAd = false
                self.interstitialShowCallback?.call(OperaAdsCallbackEventInterstitial.Failed.rawValue, error.message)
            }
        )
        interstitialShowListener = showListener
        ad.show(on: rootVC, listener: showListener)
    }

    public override func opera_ads_interstitial_destroy() -> Bool {
        interstitialAd = nil
        return true
    }

    public override func opera_ads_rewarded_load(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(false, notInitializedError)
            return
        }

        guard !rewardedPlacementId.isEmpty else {
            callback.call(false, "Rewarded placement ID is empty.")
            return
        }

        rewardedLoadCallback = callback
        rewardedAd = OpAdxRewardedAd(placementId: rewardedPlacementId, auctionType: .regular)

        let loadListener = OpAdxRewardedAdLoadListenerImp(
            onAdLoaded: { [self] _ in
                self.rewardedLoadCallback?.call(true)
            },
            onAdFailedToLoad: { [self] error in
                self.rewardedLoadCallback?.call(false, error.message)
            }
        )
        rewardedLoadListener = loadListener
        rewardedAd?.load(placementId: rewardedPlacementId, listener: loadListener)
    }

    public override func opera_ads_rewarded_is_ad_valid() -> Bool {
        guard operaAdsInitialized else { return false }
        guard let ad = rewardedAd else { return false }
        return !ad.isAdInvalidated()
    }

    public override func opera_ads_rewarded_show(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(OperaAdsCallbackEventRewarded.Failed.rawValue, notInitializedError)
            return
        }

        guard let ad = rewardedAd else {
            callback.call(OperaAdsCallbackEventRewarded.Failed.rawValue, "Rewarded ad is not loaded.")
            return
        }

        guard !ad.isAdInvalidated() else {
            _ = opera_ads_rewarded_destroy()
            callback.call(OperaAdsCallbackEventRewarded.Failed.rawValue, "Rewarded ad is invalid.")
            return
        }

        guard let rootVC = rootViewController() else {
            callback.call(OperaAdsCallbackEventRewarded.Failed.rawValue, "Could not resolve a root view controller.")
            return
        }

        if let rewardedSceneId, !rewardedSceneId.isEmpty {
            ad.setSceneId(rewardedSceneId)
        }

        if let userId = rewardedSSVUserId {
            let ssv = RewardSsvOptions.Builder()
                .userId(userId)
                .customData(rewardedSSVCustomData ?? "")
                .build()
            ad.setRewardSsvOptions(ssv)
        }

        operaAdsDisplayingAd = true
        rewardedShowCallback = callback

        let showListener = OpAdxRewardedAdInteractionListenerImp(
            onAdClicked: { [self] in
                self.rewardedShowCallback?.call(OperaAdsCallbackEventRewarded.Clicked.rawValue)
            },
            onAdDisplayed: { [self] in
                self.rewardedShowCallback?.call(OperaAdsCallbackEventRewarded.Displayed.rawValue)
            },
            onAdDismissed: { [self] in
                self.rewardedShowCallback?.call(OperaAdsCallbackEventRewarded.Dismissed.rawValue)
                self.operaAdsDisplayingAd = false
                self.rewardedAd = nil
            },
            onAdFailedToShow: { [self] error in
                self.operaAdsDisplayingAd = false
                self.rewardedShowCallback?.call(OperaAdsCallbackEventRewarded.Failed.rawValue, error.message)
            },
            onUserRewarded: { [self] reward in
                self.rewardedShowCallback?.call(
                    OperaAdsCallbackEventRewarded.Rewarded.rawValue,
                    reward.type,
                    Int32(reward.amount)
                )
            }
        )
        rewardedShowListener = showListener
        ad.show(on: rootVC, listener: showListener)
    }

    public override func opera_ads_rewarded_destroy() -> Bool {
        rewardedAd = nil
        return true
    }

    public override func opera_ads_rewarded_interstitial_load(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(false, notInitializedError)
            return
        }

        guard !rewardedInterstitialPlacementId.isEmpty else {
            callback.call(false, "Rewarded interstitial placement ID is empty.")
            return
        }

        rewardedInterstitialLoadCallback = callback
        rewardedInterstitialAd = OpAdxRewardedInterstitialAd(
            placementId: rewardedInterstitialPlacementId,
            auctionType: .regular
        )

        let loadListener = OpAdxRewardedInterstitialAdLoadListenerImp(
            onAdLoaded: { [self] _ in
                self.rewardedInterstitialLoadCallback?.call(true)
            },
            onAdFailedToLoad: { [self] error in
                self.rewardedInterstitialLoadCallback?.call(false, error.message)
            }
        )
        rewardedInterstitialLoadListener = loadListener
        rewardedInterstitialAd?.load(placementId: rewardedInterstitialPlacementId, listener: loadListener)
    }

    public override func opera_ads_rewarded_interstitial_is_ad_valid() -> Bool {
        guard operaAdsInitialized else { return false }
        guard let ad = rewardedInterstitialAd else { return false }
        return !ad.isAdInvalidated()
    }

    public override func opera_ads_rewarded_interstitial_show(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.rawValue, notInitializedError)
            return
        }

        guard let ad = rewardedInterstitialAd else {
            callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.rawValue, "Rewarded interstitial ad is not loaded.")
            return
        }

        guard !ad.isAdInvalidated() else {
            _ = opera_ads_rewarded_interstitial_destroy()
            callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.rawValue, "Rewarded interstitial ad is invalid.")
            return
        }

        guard let rootVC = rootViewController() else {
            callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.rawValue, "Could not resolve a root view controller.")
            return
        }

        if let rewardedInterstitialSceneId, !rewardedInterstitialSceneId.isEmpty {
            ad.setSceneId(rewardedInterstitialSceneId)
        }

        if let userId = rewardedInterstitialSSVUserId {
            let ssv = RewardSsvOptions.Builder()
                .userId(userId)
                .customData(rewardedInterstitialSSVCustomData ?? "")
                .build()
            ad.setRewardSsvOptions(ssv)
        }

        operaAdsDisplayingAd = true
        rewardedInterstitialShowCallback = callback

        let showListener = OpAdxRewardedInterstitialAdInteractionListenerImp(
            onAdClicked: { [self] in
                self.rewardedInterstitialShowCallback?.call(OperaAdsCallbackEventRewardedInterstitial.Clicked.rawValue)
            },
            onAdDisplayed: { [self] in
                self.rewardedInterstitialShowCallback?.call(OperaAdsCallbackEventRewardedInterstitial.Displayed.rawValue)
            },
            onAdDismissed: { [self] in
                self.rewardedInterstitialShowCallback?.call(OperaAdsCallbackEventRewardedInterstitial.Dismissed.rawValue)
                self.rewardedInterstitialAd = nil
                self.operaAdsDisplayingAd = false
            },
            onAdFailedToShow: { [self] error in
                self.operaAdsDisplayingAd = false
                self.rewardedInterstitialShowCallback?.call(OperaAdsCallbackEventRewardedInterstitial.Failed.rawValue, error.message)
            },
            onUserRewarded: { [self] reward in
                self.rewardedInterstitialShowCallback?.call(
                    OperaAdsCallbackEventRewardedInterstitial.Rewarded.rawValue,
                    reward.type,
                    Int32(reward.amount)
                )
            }
        )
        rewardedInterstitialShowListener = showListener
        ad.show(on: rootVC, listener: showListener)
    }

    public override func opera_ads_rewarded_interstitial_destroy() -> Bool {
        rewardedInterstitialAd = nil
        return true
    }

    public override func opera_ads_app_open_enable(callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(OperaAdsCallbackEventAppOpen.LoadFailed.rawValue, notInitializedError)
            return
        }

        openAdsPlacementIdActive = appOpenPlacementId
        guard !openAdsPlacementIdActive.isEmpty else {
            callback.call(OperaAdsCallbackEventAppOpen.LoadFailed.rawValue, "App open placement ID is empty.")
            return
        }

        appOpenCallback = callback
        opera_ads_app_open_load(placementId: openAdsPlacementIdActive)
    }

    public override func opera_ads_app_open_disable() -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_app_open_disable :: SDK is not initialized.")
            return false
        }
        openAdsPlacementIdActive = ""
        appOpenCallback = nil
        operaAdsDisplayingAd = false
        opera_ads_app_open_destroyInternal()
        return true
    }

    public override func opera_ads_app_open_is_enabled() -> Bool {
        guard operaAdsInitialized else { return false }
        return !openAdsPlacementIdActive.isEmpty
    }

    public override func opera_ads_banner_load(size: OperaAdsBannerSize, callback: GMFunction) {
        guard operaAdsInitialized else {
            callback.call(OperaAdsCallbackEventBanner.LoadFailed.rawValue, notInitializedError)
            return
        }

        guard !bannerPlacementId.isEmpty else {
            callback.call(OperaAdsCallbackEventBanner.LoadFailed.rawValue, "Banner placement ID is empty.")
            return
        }

        guard !bannerLoadedOnce else {
            callback.call(OperaAdsCallbackEventBanner.LoadFailed.rawValue, "Banner ad view has already been loaded. Destroy it before loading again.")
            return
        }

        guard !bannerLoadInProgress else {
            callback.call(OperaAdsCallbackEventBanner.LoadFailed.rawValue, "Banner ad load is already in progress.")
            return
        }

        bannerSize = size
        bannerLoadInProgress = true
        bannerLoadCallback = callback

        let banner = OpAdxBannerAdView()
        banner.setPlacementId(bannerPlacementId)
        banner.setAdSize(bannerAdSize(for: size))
        banner.setAutoRefreshInterval(bannerAutoRefreshInterval)
        bannerAdView = banner

        let listener = OpAdxBannerAdListenerImp(
            onAdLoaded: { [self] _ in
                self.bannerLoaded = true
                self.bannerLoadedOnce = true
                self.bannerLoadInProgress = false
                self.bannerLoadCallback?.call(OperaAdsCallbackEventBanner.Loaded.rawValue)
            },
            onAdFailedToLoad: { [self] error in
                self.bannerLoaded = false
                self.bannerLoadInProgress = false
                _ = self.opera_ads_banner_destroy()
                self.bannerLoadCallback?.call(OperaAdsCallbackEventBanner.LoadFailed.rawValue, error.message)
            },
            onAdImpression: { [self] in
                self.bannerLoadCallback?.call(OperaAdsCallbackEventBanner.Impression.rawValue)
            },
            onAdClicked: { [self] in
                self.bannerLoadCallback?.call(OperaAdsCallbackEventBanner.Clicked.rawValue)
            }
        )
        bannerListener = listener
        banner.loadAd(listener: listener)
    }

    public override func opera_ads_banner_is_ad_valid() -> Bool {
        guard operaAdsInitialized else { return false }
        guard bannerAdView != nil else { return false }
        return bannerLoaded
    }

    public override func opera_ads_banner_show(position: OperaAdsBannerPosition) -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_banner_show :: SDK is not initialized.")
            return false
        }
        guard bannerAdView != nil else {
            NSLog("[GMOperaAds] opera_ads_banner_show :: No banner ad loaded.")
            return false
        }
        bannerPosition = position

        DispatchQueue.main.async { [self] in
            guard let banner = self.bannerAdView else { return }
            guard let container = self.bannerContainerView() else { return }

            if !self.bannerAdded {
                // Create a transparent wrapper so we only ever move the wrapper,
                // never the banner ad view itself. This prevents conflicts with
                // any Auto Layout the SDK uses internally inside bannerAdView.
                let adSize = self.bannerAdSize(for: self.bannerSize)
                let bw = CGFloat(adSize.width)
                let bh = CGFloat(adSize.height)
                let wrapper = UIView(frame: CGRect(x: 0, y: 0, width: bw, height: bh))
                wrapper.backgroundColor = .clear
                wrapper.clipsToBounds = false
                wrapper.translatesAutoresizingMaskIntoConstraints = true

                banner.removeFromSuperview()
                banner.translatesAutoresizingMaskIntoConstraints = true
                banner.frame = CGRect(x: 0, y: 0, width: bw, height: bh)
                wrapper.addSubview(banner)
                container.addSubview(wrapper)
                self.bannerWrapper = wrapper
                self.bannerAdded = true
            }

            self.applyBannerPositionConstraints()
            self.bannerVisible = true
        }
        return true
    }

    public override func opera_ads_banner_move(position: OperaAdsBannerPosition) -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_banner_move :: SDK is not initialized.")
            return false
        }
        guard bannerAdView != nil, bannerAdded else {
            NSLog("[GMOperaAds] opera_ads_banner_move :: No banner ad shown.")
            return false
        }

        bannerPosition = position
        if Thread.isMainThread {
            applyBannerPositionConstraints()
        } else {
            DispatchQueue.main.async { [self] in
                guard self.bannerWrapper != nil, self.bannerAdded else { return }
                self.applyBannerPositionConstraints()
            }
        }
        return true
    }

    public override func opera_ads_banner_destroy() -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_banner_destroy :: SDK is not initialized.")
            return false
        }
        bannerLoadInProgress = false

        DispatchQueue.main.async { [self] in
            self.bannerAdView?.removeFromSuperview()
            self.bannerAdView?.destroy()
            self.bannerAdView = nil
            self.bannerWrapper?.removeFromSuperview()
            self.bannerWrapper = nil

            self.bannerAdded = false
            self.bannerVisible = false
            self.bannerLoaded = false
            self.bannerLoadedOnce = false
            self.bannerLoadInProgress = false
        }

        return true
    }

    public override func opera_ads_banner_hide() -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_banner_hide :: SDK is not initialized.")
            return false
        }
        guard bannerAdView != nil else {
            NSLog("[GMOperaAds] opera_ads_banner_hide :: No banner ad loaded.")
            return false
        }
        DispatchQueue.main.async { [self] in
            self.bannerWrapper?.isHidden = true
            self.bannerVisible = false
        }
        return true
    }

    public override func opera_ads_banner_unhide() -> Bool {
        guard operaAdsInitialized else {
            NSLog("[GMOperaAds] opera_ads_banner_unhide :: SDK is not initialized.")
            return false
        }
        guard bannerAdView != nil else {
            NSLog("[GMOperaAds] opera_ads_banner_unhide :: No banner ad loaded.")
            return false
        }
        guard bannerLoaded else { return false }

        DispatchQueue.main.async { [self] in
            guard let wrapper = self.bannerWrapper else { return }
            wrapper.isHidden = false
            if let container = self.bannerContainerView() {
                container.bringSubview(toFront: wrapper)
            }
            self.bannerVisible = true
        }
        return true
    }

    public override func opera_ads_banner_is_visible() -> Bool {
        bannerVisible
    }

    public override func opera_ads_rewarded_set_scene(scene_id: String) {
        rewardedSceneId = scene_id
    }

    public override func opera_ads_rewarded_set_reward_ssv_options(user_id: String, custom_data: String) {
        rewardedSSVUserId = user_id
        rewardedSSVCustomData = custom_data
    }

    public override func opera_ads_rewarded_interstitial_set_scene(scene_id: String) {
        rewardedInterstitialSceneId = scene_id
    }

    public override func opera_ads_rewarded_interstitial_set_reward_ssv_options(user_id: String, custom_data: String) {
        rewardedInterstitialSSVUserId = user_id
        rewardedInterstitialSSVCustomData = custom_data
    }

    public func onResume() {
        guard operaAdsInitialized else { return }
        bannerAdView?.resume()

        guard !operaAdsDisplayingAd else { return }
        guard opera_ads_app_open_is_enabled() else { return }

        if opera_ads_app_open_is_ad_valid() {
            opera_ads_app_open_show()
        } else {
            opera_ads_app_open_load(placementId: openAdsPlacementIdActive)
        }
    }

    public func onStop() {
        bannerAdView?.pause()
    }

    public func onDestroy() {
        _ = opera_ads_interstitial_destroy()
        _ = opera_ads_rewarded_destroy()
        _ = opera_ads_rewarded_interstitial_destroy()
        opera_ads_app_open_destroyInternal()
        _ = opera_ads_banner_destroy()

        interstitialLoadCallback = nil
        interstitialShowCallback = nil
        rewardedLoadCallback = nil
        rewardedShowCallback = nil
        rewardedInterstitialLoadCallback = nil
        rewardedInterstitialShowCallback = nil
        appOpenCallback = nil
        bannerLoadCallback = nil

        openAdsPlacementIdActive = ""
        bannerWrapper = nil
        bannerAdded = false
        bannerVisible = false
        bannerLoaded = false
        bannerLoadedOnce = false
        bannerLoadInProgress = false
        operaAdsDisplayingAd = false
    }
}

private extension GMOperaAdsSwift {
    func bannerAdSize(for size: OperaAdsBannerSize) -> OpAdxAdSize {
        switch size {
        case .Banner:            return .BANNER
        case .BannerLarge:       return OpAdxAdSize(width: 320, height: 100)
        case .BannerMREC:        return .BANNER_MREC
        case .BannerLeaderboard: return OpAdxAdSize(width: 728, height: 90)
        case .BannerSmart:       return .BANNER
        default:                 return .BANNER_MREC
        }
    }

    func applyPrivacyOptions() {
        let defaults = UserDefaults.standard
        defaults.set(gdprApplies ? 1 : 0, forKey: "IABTCF_gdprApplies")
        defaults.set(gdprConsentString, forKey: "IABTCF_TCString")
        defaults.set(usPrivacyString, forKey: "IABUSPrivacy_String")
        defaults.set(coppa ? 1 : 0, forKey: "opera_ads_coppa")
        defaults.synchronize()
    }

    func extensionOption(ext: String, opt: String) -> String {
        var extCString = Array(ext.utf8CString)
        var optCString = Array(opt.utf8CString)
        guard let raw = extOptGetString(&extCString, &optCString) else { return "" }
        return String(cString: raw)
    }

    func rootViewController() -> UIViewController? {
        if let scene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive }),
           let root = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            return root
        }

        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })?
            .rootViewController
    }

    func bannerContainerView() -> UIView? {
        getGLView()
    }

    func opera_ads_app_open_load(placementId: String) {
        guard operaAdsInitialized, !placementId.isEmpty else { return }

        appOpenAd = OpAdxAppOpenAd(placementId: placementId, auctionType: .regular)

        let loadListener = OpAdxAppOpenAdLoadListenerImp(
            onAdLoaded: { [self] _ in
                self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Loaded.rawValue)
            },
            onAdFailedToLoad: { [self] error in
                if self.operaAdsDisplayingAd {
                    self.opera_ads_app_open_destroyInternal()
                    self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Failed.rawValue, error.message)
                } else {
                    self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.LoadFailed.rawValue, error.message)
                }
            }
        )
        appOpenLoadListener = loadListener
        appOpenAd?.load(placementId: placementId, listener: loadListener)
    }

    func opera_ads_app_open_is_ad_valid() -> Bool {
        guard let ad = appOpenAd else { return false }
        return !ad.isAdInvalidated()
    }

    func opera_ads_app_open_show() {
        guard operaAdsInitialized else { return }
        guard opera_ads_app_open_is_enabled() else { return }
        guard let ad = appOpenAd, !ad.isAdInvalidated() else {
            opera_ads_app_open_destroyInternal()
            return
        }
        guard let rootVC = rootViewController() else { return }

        let showListener = OpAdxAppOpenAdInteractionListenerImp(
            onAdClicked: { [self] in
                self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Clicked.rawValue)
            },
            onAdDisplayed: { [self] in
                self.opera_ads_app_open_load(placementId: self.openAdsPlacementIdActive)
                self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Displayed.rawValue)
            },
            onAdDismissed: { [self] in
                self.opera_ads_app_open_destroyInternal()
                self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Dismissed.rawValue)
            },
            onAdFailedToShow: { [self] error in
                self.opera_ads_app_open_destroyInternal()
                self.appOpenCallback?.call(OperaAdsCallbackEventAppOpen.Failed.rawValue, error.message)
            }
        )
        appOpenShowListener = showListener
        ad.show(on: rootVC, listener: showListener)
    }

    func opera_ads_app_open_destroyInternal() {
        appOpenAd = nil
    }

    func applyBannerPositionConstraints() {
        guard let wrapper = bannerWrapper, bannerAdded else { return }
        // Use wrapper.superview directly — avoids repeated getGLView() C calls which
        // caused ARC over-retain and EXC_BAD_ACCESS after ~7 moves.
        guard let container = wrapper.superview else { return }

        let adSize = bannerAdSize(for: bannerSize)
        let bw = CGFloat(adSize.width)
        let bh = CGFloat(adSize.height)
        let bounds = container.bounds
        let insets = container.safeAreaInsets

        let safeLeft   = insets.left
        let safeRight  = bounds.width  - insets.right
        let safeTop    = insets.top
        let safeBottom = bounds.height - insets.bottom

        var x: CGFloat
        var y: CGFloat

        switch bannerPosition {
        case .TopLeft:
            x = safeLeft; y = safeTop
        case .TopCenter:
            x = (bounds.width - bw) / 2; y = safeTop
        case .TopRight:
            x = safeRight - bw; y = safeTop
        case .MiddleLeft:
            x = safeLeft; y = (bounds.height - bh) / 2
        case .MiddleCenter:
            x = (bounds.width - bw) / 2; y = (bounds.height - bh) / 2
        case .MiddleRight:
            x = safeRight - bw; y = (bounds.height - bh) / 2
        case .BottomLeft:
            x = safeLeft; y = safeBottom - bh
        case .BottomCenter:
            x = (bounds.width - bw) / 2; y = safeBottom - bh
        case .BottomRight:
            x = safeRight - bw; y = safeBottom - bh
        default:
            x = (bounds.width - bw) / 2; y = safeTop
        }

        wrapper.frame = CGRect(x: x, y: y, width: bw, height: bh)
    }
}
