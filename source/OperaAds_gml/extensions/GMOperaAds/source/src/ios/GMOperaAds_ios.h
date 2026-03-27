#import <Foundation/Foundation.h>
#import "ios/GMOperaAdsInternal_ios.h"

#import "OpAdxSdk/OpAdxSDK.h"

@interface GMOperaAds : GMOperaAdsInternal <GMOperaAdsInterface,OpAdxInterstitialAdDelegate,OpAdxRewardedAdDelegate,OpAdxRewardedInterstitialAdDelegate,OpAdxAppOpenAdDelegate,OpAdxBannerAdDelegate>

@property (nonatomic, strong, nullable) OpAdxInterstitialAdBridge *interstitialAd;
@property (nonatomic, strong, nullable) OpAdxRewardedAdBridge *rewardedAd;
@property (nonatomic, strong, nullable) OpAdxRewardedInterstitialAdBridge *rewardedInterstitialAd;
@property (nonatomic, strong, nullable) OpAdxAppOpenAdBridge *appOpenAd;
@property (nonatomic, strong, nullable) OpAdxBannerAdBridge *bannerAdView;

@property (nonatomic, strong, nonnull) NSString *interstitialPlacementId;
@property (nonatomic, strong, nonnull) NSString *rewardedPlacementId;
@property (nonatomic, strong, nonnull) NSString *rewardedInterstitialPlacementId;
@property (nonatomic, strong, nonnull) NSString *appOpenPlacementId;
@property (nonatomic, strong, nonnull) NSString *bannerPlacementId;
@property (nonatomic, strong, nullable) NSString *openAdsPlacementIdActive;

@property (nonatomic, assign) BOOL bannerAdded;
@property (nonatomic, assign) gm_enums::OperaAdsBannerPosition bannerPosition;
@property (nonatomic, strong, nonnull) NSArray<NSLayoutConstraint *> *bannerConstraints;
@property (nonatomic, assign) BOOL bannerVisible;
@property (nonatomic, assign) BOOL bannerLoaded;
@property (nonatomic, assign) BOOL bannerLoadedOnce;
@property (nonatomic, assign) BOOL bannerLoadInProgress;

@end


