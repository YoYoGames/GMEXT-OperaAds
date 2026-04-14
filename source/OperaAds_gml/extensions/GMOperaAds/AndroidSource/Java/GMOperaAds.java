package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.enums.*;

import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.GMExtUtils;

import androidx.annotation.NonNull;

import android.app.Activity;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import com.opera.ads.AdError;
import com.opera.ads.OperaAds;
import com.opera.ads.privacy.PrivacyManager;
import com.opera.ads.initialization.OnSdkInitCompleteListener;
import com.opera.ads.initialization.SdkInitConfig;

import com.opera.ads.interstitial.InterstitialAd;
import com.opera.ads.interstitial.InterstitialAdInteractionListener;
import com.opera.ads.interstitial.InterstitialAdLoadListener;

import com.opera.ads.RewardItem;
import com.opera.ads.RewardSsvOptions;
import com.opera.ads.rewarded.RewardedAd;
import com.opera.ads.rewarded.RewardedAdInteractionListener;
import com.opera.ads.rewarded.RewardedAdLoadListener;

import com.opera.ads.rewardedinterstitial.RewardedInterstitialAd;
import com.opera.ads.rewardedinterstitial.RewardedInterstitialAdInteractionListener;
import com.opera.ads.rewardedinterstitial.RewardedInterstitialAdLoadListener;

import com.opera.ads.appopen.AppOpenAd;
import com.opera.ads.appopen.AppOpenAdInteractionListener;
import com.opera.ads.appopen.AppOpenAdLoadListener;

import android.view.ViewGroup;
import android.view.Gravity;
import android.widget.FrameLayout;
import com.opera.ads.AdSize;
import com.opera.ads.banner.BannerAd;
import com.opera.ads.banner.BannerAdListener;
import com.opera.ads.banner.BannerAdView;

public class GMOperaAds extends GMOperaAdsInternal {

	// -------------------------------------------------------------------------
	// Helpers
	// -------------------------------------------------------------------------

	private Activity opera_ads_get_activity() {
		return RunnerActivity.CurrentActivity;
	}

	private ViewGroup opera_ads_get_root_view(Activity activity) {
		if (activity == null) return null;
		return activity.findViewById(android.R.id.content);
	}

	private SharedPreferences opera_ads_get_default_preferences() {
		Activity activity = opera_ads_get_activity();
		if (activity == null) return null;
		return PreferenceManager.getDefaultSharedPreferences(activity.getApplicationContext());
	}

	// -------------------------------------------------------------------------
	// State
	// -------------------------------------------------------------------------

	private static final String ERR_NOT_INITIALIZED = "Opera Ads SDK is not initialized.";

	private boolean mOperaAdsInitialized = false;
	private boolean mOperaAdsDisplayingAd = false;

	private String mGdprConsentString = "";
	private boolean mGdprApplies = false;
	private String mUSPrivacyString = "";
	private boolean mCoppa = false;

	private String mPublisherName = "";
	private String mInterstitialPlacementId = "";
	private String mRewardedPlacementId = "";
	private String mRewardedInterstitialPlacementId = "";
	private String mAppOpenPlacementId = "";
	private String mBannerPlacementId = "";

	// -------------------------------------------------------------------------
	// Privacy
	// -------------------------------------------------------------------------

	private void opera_ads_apply_privacy_options() {
		// Write IAB TCF standard keys for GDPR (read automatically by the SDK)
		SharedPreferences prefs = opera_ads_get_default_preferences();
		if (prefs != null) {
			prefs.edit()
				.putInt("IABTCF_gdprApplies", mGdprApplies ? 1 : 0)
				.putString("IABTCF_TCString", mGdprConsentString != null ? mGdprConsentString : "")
				.putString("IABUSPrivacy_String", mUSPrivacyString != null ? mUSPrivacyString : "")
				.apply();
		}
		// Use SDK PrivacyManager API for COPPA and US Privacy
		PrivacyManager.setCoppa(mCoppa ? 1 : 0);
		if (mUSPrivacyString != null && !mUSPrivacyString.isEmpty()) {
			PrivacyManager.setUSPrivacy(mUSPrivacyString);
		}
	}

	// -------------------------------------------------------------------------
	// Init
	// -------------------------------------------------------------------------

	public boolean opera_ads_init(GMFunction callback) {
		String app_id = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Application Id");
		if (mPublisherName.isEmpty()) mPublisherName = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Publisher Name");

		if (mInterstitialPlacementId.isEmpty()) mInterstitialPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Interstitial");
		if (mRewardedPlacementId.isEmpty()) mRewardedPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Rewarded");
		if (mRewardedInterstitialPlacementId.isEmpty()) mRewardedInterstitialPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Rewarded Interstitial");
		if (mAppOpenPlacementId.isEmpty()) mAppOpenPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds", "Android App Open");
		if (mBannerPlacementId.isEmpty()) mBannerPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds", "Android Banner");

		mBannerVisible = false;
		opera_ads_apply_privacy_options();

		Activity activity = opera_ads_get_activity();
		if (activity == null) {
			callback.call(false, "Current Android activity is unavailable.");
			return false;
		}

		SdkInitConfig.Builder builder = new SdkInitConfig.Builder(app_id)
			.publisherName(mPublisherName)
			//.testAds(true)
			.coppa(mCoppa ? 1 : 0);

		if (mUSPrivacyString != null && !mUSPrivacyString.isEmpty()) {
			builder = builder.usPrivacy(mUSPrivacyString);
		}

		OperaAds.initialize(activity,
			builder.build(),
			new OnSdkInitCompleteListener() {
				@Override
				public void onSuccess() {
					mOperaAdsInitialized = true;
					callback.call(true);
				}

				@Override
				public void onError(@NonNull AdError error) {
					callback.call(false, error.getMessage());
				}
			});

		return true;
	}

	// -------------------------------------------------------------------------
	// Settings
	// -------------------------------------------------------------------------

	public boolean opera_ads_is_initialized() {
		return mOperaAdsInitialized;
	}

	public boolean opera_ads_set_mute(boolean mute) {
		if (!mOperaAdsInitialized) return false;
		OperaAds.setMuted(mute);
		return true;
	}

	public void opera_ads_set_gdpr(String consent_string, boolean applies) {
		mGdprConsentString = consent_string != null ? consent_string : "";
		mGdprApplies = applies;
		opera_ads_apply_privacy_options();
	}

	public void opera_ads_set_us_privacy(String us_privacy) {
		mUSPrivacyString = us_privacy != null ? us_privacy : "";
		opera_ads_apply_privacy_options();
	}

	public void opera_ads_set_coppa(boolean coppa) {
		mCoppa = coppa;
		opera_ads_apply_privacy_options();
	}

	public String opera_ads_get_gdpr() {
		return mGdprConsentString;
	}

	public boolean opera_ads_get_gdpr_applies() {
		return mGdprApplies;
	}

	public String opera_ads_get_us_privacy() {
		return mUSPrivacyString;
	}

	public boolean opera_ads_get_coppa() {
		return mCoppa;
	}

	public void opera_ads_set_publisher_name(String publisher_name) {
		mPublisherName = publisher_name != null ? publisher_name : "";
	}

	// -------------------------------------------------------------------------
	// Placement IDs
	// -------------------------------------------------------------------------

	public void opera_ads_interstitial_set_placement_id(String placement_id) {
		mInterstitialPlacementId = placement_id != null ? placement_id : "";
	}

	public void opera_ads_rewarded_set_placement_id(String placement_id) {
		mRewardedPlacementId = placement_id != null ? placement_id : "";
	}

	public void opera_ads_rewarded_interstitial_set_placement_id(String placement_id) {
		mRewardedInterstitialPlacementId = placement_id != null ? placement_id : "";
	}

	public void opera_ads_app_open_set_placement_id(String placement_id) {
		mAppOpenPlacementId = placement_id != null ? placement_id : "";
		if (mAppOpenAd != null) {
			opera_ads_app_open_destroy();
		}
	}

	public void opera_ads_banner_set_placement_id(String placement_id) {
		mBannerPlacementId = placement_id != null ? placement_id : "";
	}

	public void opera_ads_banner_set_auto_refresh(double interval) {
		mBannerAutoRefreshInterval = (int) interval;
		if (mBannerAdView != null) {
			if (mBannerAutoRefreshInterval > 0) {
				mBannerAdView.setAutoRefreshInterval(mBannerAutoRefreshInterval);
			} else {
				mBannerAdView.setAutoRefreshEnabled(false);
			}
		}
	}

	// -------------------------------------------------------------------------
	// Interstitial
	// -------------------------------------------------------------------------

	private InterstitialAd mInterstitialAd = null;
	private GMFunction mInterstitialLoadCallback = null;
	private GMFunction mInterstitialShowCallback = null;

	public void opera_ads_interstitial_load(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}

		if (mInterstitialPlacementId.isEmpty()) {
			callback.call(false, "Interstitial placement ID is empty.");
			return;
		}

		mInterstitialLoadCallback = callback;
		final String placementId = mInterstitialPlacementId;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mInterstitialLoadCallback.call(false, "Current Android activity is unavailable.");
				return;
			}
			InterstitialAd.load(activity, placementId, new InterstitialAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull InterstitialAd ad) {
					mInterstitialAd = ad;
					mInterstitialLoadCallback.call(true);
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					mInterstitialLoadCallback.call(false, error.getMessage());
				}
			});
		});
	}

	public boolean opera_ads_interstitial_is_ad_valid() {
		if (!mOperaAdsInitialized) return false;
		if (mInterstitialAd == null) return false;
		return !mInterstitialAd.isAdInvalidated();
	}

	public void opera_ads_interstitial_show(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (mInterstitialAd == null) {
			callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), "Interstitial ad is not loaded.");
			return;
		}

		if (mInterstitialAd.isAdInvalidated()) {
			opera_ads_interstitial_destroy();
			callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), "Interstitial ad is invalid.");
			return;
		}

		mInterstitialShowCallback = callback;
		mOperaAdsDisplayingAd = true;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mInterstitialShowCallback.call(OperaAdsCallbackEventInterstitial.Failed.value(), "Current Android activity is unavailable.");
				mOperaAdsDisplayingAd = false;
				return;
			}
			mInterstitialAd.show(activity, new InterstitialAdInteractionListener() {
				@Override
				public void onAdClicked() {
					mInterstitialShowCallback.call(OperaAdsCallbackEventInterstitial.Clicked.value());
				}

				@Override
				public void onAdDisplayed() {
					mInterstitialShowCallback.call(OperaAdsCallbackEventInterstitial.Displayed.value());
				}

				@Override
				public void onAdDismissed() {
					mInterstitialShowCallback.call(OperaAdsCallbackEventInterstitial.Dismissed.value());
					mOperaAdsDisplayingAd = false;
					opera_ads_interstitial_destroy();
				}

				@Override
				public void onAdFailedToShow(@NonNull AdError error) {
					mInterstitialShowCallback.call(OperaAdsCallbackEventInterstitial.Failed.value(), error.getMessage());
					mOperaAdsDisplayingAd = false;
					opera_ads_interstitial_destroy();
				}
			});
		});
	}

	public boolean opera_ads_interstitial_destroy() {
		if (mInterstitialAd != null) {
			mInterstitialAd.destroy();
			mInterstitialAd = null;
		}
		return true;
	}

	// -------------------------------------------------------------------------
	// Rewarded
	// -------------------------------------------------------------------------

	private RewardedAd mRewardedAd = null;
	private GMFunction mRewardedLoadCallback = null;
	private GMFunction mRewardedShowCallback = null;
	private String mRewardedSceneId = null;
	private String mRewardedSSVUserId = null;
	private String mRewardedSSVCustomData = null;

	public void opera_ads_rewarded_load(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}

		if (mRewardedPlacementId.isEmpty()) {
			callback.call(false, "Rewarded placement ID is empty.");
			return;
		}

		mRewardedLoadCallback = callback;
		final String placementId = mRewardedPlacementId;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mRewardedLoadCallback.call(false, "Current Android activity is unavailable.");
				return;
			}
			RewardedAd.load(activity, placementId, new RewardedAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull RewardedAd ad) {
					mRewardedAd = ad;
					mRewardedLoadCallback.call(true);
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					mRewardedLoadCallback.call(false, error.getMessage());
				}
			});
		});
	}

	public boolean opera_ads_rewarded_is_ad_valid() {
		if (!mOperaAdsInitialized) return false;
		if (mRewardedAd == null) return false;
		return !mRewardedAd.isAdInvalidated();
	}

	public void opera_ads_rewarded_show(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventRewarded.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (mRewardedAd == null) {
			callback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Rewarded ad is not loaded.");
			return;
		}

		if (mRewardedAd.isAdInvalidated()) {
			opera_ads_rewarded_destroy();
			callback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Rewarded ad is invalid.");
			return;
		}

		if (mRewardedSceneId != null && !mRewardedSceneId.isEmpty()) {
			mRewardedAd.setSceneId(mRewardedSceneId);
		}

		if (mRewardedSSVUserId != null) {
			mRewardedAd.setRewardSsvOptions(new RewardSsvOptions.Builder()
				.userId(mRewardedSSVUserId)
				.customData(mRewardedSSVCustomData != null ? mRewardedSSVCustomData : "")
				.build());
		}

		mRewardedShowCallback = callback;
		mOperaAdsDisplayingAd = true;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Current Android activity is unavailable.");
				mOperaAdsDisplayingAd = false;
				return;
			}
			mRewardedAd.show(activity, new RewardedAdInteractionListener() {
				@Override
				public void onAdClicked() {
					mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Clicked.value());
				}

				@Override
				public void onAdDisplayed() {
					mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Displayed.value());
				}

				@Override
				public void onAdDismissed() {
					mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Dismissed.value());
					mOperaAdsDisplayingAd = false;
					opera_ads_rewarded_destroy();
				}

				@Override
				public void onAdFailedToShow(@NonNull AdError error) {
					mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Failed.value(), error.getMessage());
					mOperaAdsDisplayingAd = false;
					opera_ads_rewarded_destroy();
				}

				@Override
				public void onUserRewarded(@NonNull RewardItem reward) {
					mRewardedShowCallback.call(OperaAdsCallbackEventRewarded.Rewarded.value(), reward.type, reward.amount);
				}
			});
		});
	}

	public boolean opera_ads_rewarded_destroy() {
		if (mRewardedAd != null) {
			mRewardedAd.destroy();
			mRewardedAd = null;
		}
		return true;
	}

	public void opera_ads_rewarded_set_scene(String scene_id) {
		mRewardedSceneId = scene_id;
	}

	public void opera_ads_rewarded_set_reward_ssv_options(String user_id, String custom_data) {
		mRewardedSSVUserId = user_id;
		mRewardedSSVCustomData = custom_data;
	}

	// -------------------------------------------------------------------------
	// Rewarded Interstitial
	// -------------------------------------------------------------------------

	private RewardedInterstitialAd mRewardedInterstitialAd = null;
	private GMFunction mRewardedInterstitialLoadCallback = null;
	private GMFunction mRewardedInterstitialShowCallback = null;
	private String mRewardedInterstitialSceneId = null;
	private String mRewardedInterstitialSSVUserId = null;
	private String mRewardedInterstitialSSVCustomData = null;

	public void opera_ads_rewarded_interstitial_load(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}

		if (mRewardedInterstitialPlacementId.isEmpty()) {
			callback.call(false, "Rewarded interstitial placement ID is empty.");
			return;
		}

		mRewardedInterstitialLoadCallback = callback;
		final String placementId = mRewardedInterstitialPlacementId;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mRewardedInterstitialLoadCallback.call(false, "Current Android activity is unavailable.");
				return;
			}
			RewardedInterstitialAd.load(activity, placementId, new RewardedInterstitialAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull RewardedInterstitialAd ad) {
					mRewardedInterstitialAd = ad;
					mRewardedInterstitialLoadCallback.call(true);
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					mRewardedInterstitialLoadCallback.call(false, error.getMessage());
				}
			});
		});
	}

	public boolean opera_ads_rewarded_interstitial_is_ad_valid() {
		if (!mOperaAdsInitialized) return false;
		if (mRewardedInterstitialAd == null) return false;
		return !mRewardedInterstitialAd.isAdInvalidated();
	}

	public void opera_ads_rewarded_interstitial_show(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (mRewardedInterstitialAd == null) {
			callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Rewarded interstitial ad is not loaded.");
			return;
		}

		if (mRewardedInterstitialAd.isAdInvalidated()) {
			opera_ads_rewarded_interstitial_destroy();
			callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Rewarded interstitial ad is invalid.");
			return;
		}

		if (mRewardedInterstitialSceneId != null && !mRewardedInterstitialSceneId.isEmpty()) {
			mRewardedInterstitialAd.setSceneId(mRewardedInterstitialSceneId);
		}

		if (mRewardedInterstitialSSVUserId != null) {
			mRewardedInterstitialAd.setRewardSsvOptions(new RewardSsvOptions.Builder()
				.userId(mRewardedInterstitialSSVUserId)
				.customData(mRewardedInterstitialSSVCustomData != null ? mRewardedInterstitialSSVCustomData : "")
				.build());
		}

		mRewardedInterstitialShowCallback = callback;
		mOperaAdsDisplayingAd = true;

		RunnerActivity.ViewHandler.post(() -> {
			Activity activity = opera_ads_get_activity();
			if (activity == null) {
				mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Current Android activity is unavailable.");
				mOperaAdsDisplayingAd = false;
				return;
			}
			mRewardedInterstitialAd.show(activity, new RewardedInterstitialAdInteractionListener() {
				@Override
				public void onAdClicked() {
					mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Clicked.value());
				}

				@Override
				public void onAdDisplayed() {
					mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Displayed.value());
				}

				@Override
				public void onAdDismissed() {
					mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Dismissed.value());
					mOperaAdsDisplayingAd = false;
					opera_ads_rewarded_interstitial_destroy();
				}

				@Override
				public void onAdFailedToShow(@NonNull AdError error) {
					mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), error.getMessage());
					mOperaAdsDisplayingAd = false;
					opera_ads_rewarded_interstitial_destroy();
				}

				@Override
				public void onUserRewarded(@NonNull RewardItem reward) {
					mRewardedInterstitialShowCallback.call(OperaAdsCallbackEventRewardedInterstitial.Rewarded.value(), reward.type, reward.amount);
				}
			});
		});
	}

	public boolean opera_ads_rewarded_interstitial_destroy() {
		if (mRewardedInterstitialAd != null) {
			mRewardedInterstitialAd.destroy();
			mRewardedInterstitialAd = null;
		}
		return true;
	}

	public void opera_ads_rewarded_interstitial_set_scene(String scene_id) {
		mRewardedInterstitialSceneId = scene_id;
	}

	public void opera_ads_rewarded_interstitial_set_reward_ssv_options(String user_id, String custom_data) {
		mRewardedInterstitialSSVUserId = user_id;
		mRewardedInterstitialSSVCustomData = custom_data;
	}

	// -------------------------------------------------------------------------
	// App Open
	// -------------------------------------------------------------------------

	private AppOpenAd mAppOpenAd = null;
	private String mOpenAdsPlacementId = "";
	private GMFunction mOpenAdsCallback = null;

	public void opera_ads_app_open_enable(GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventAppOpen.LoadFailed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (mAppOpenPlacementId.isEmpty()) {
			callback.call(OperaAdsCallbackEventAppOpen.LoadFailed.value(), "App open placement ID is empty.");
			return;
		}

		mOpenAdsPlacementId = mAppOpenPlacementId;
		mOpenAdsCallback = callback;
		opera_ads_app_open_load();
	}

	public boolean opera_ads_app_open_disable() {
		if (!mOperaAdsInitialized) return false;
		mOpenAdsPlacementId = "";
		mOpenAdsCallback = null;
		mOperaAdsDisplayingAd = false;
		opera_ads_app_open_destroy();
		return true;
	}

	public boolean opera_ads_app_open_is_enabled() {
		if (!mOperaAdsInitialized) return false;
		return !mOpenAdsPlacementId.isEmpty();
	}

	private void opera_ads_app_open_load() {
		if (!mOperaAdsInitialized || mOpenAdsPlacementId.isEmpty()) return;

		Activity activity = opera_ads_get_activity();
		if (activity == null) return;

		AppOpenAd.load(activity, mOpenAdsPlacementId, new AppOpenAdLoadListener() {
			@Override
			public void onAdLoaded(@NonNull AppOpenAd ad) {
				mAppOpenAd = ad;
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Loaded.value());
			}

			@Override
			public void onAdFailedToLoad(@NonNull AdError error) {
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.LoadFailed.value(), error.getMessage());
			}
		});
	}

	private boolean opera_ads_app_open_is_ad_valid() {
		if (mAppOpenAd == null) return false;
		return !mAppOpenAd.isAdInvalidated();
	}

	private void opera_ads_app_open_show() {
		if (!mOperaAdsInitialized) return;
		if (mAppOpenAd == null) return;

		if (mAppOpenAd.isAdInvalidated()) {
			opera_ads_app_open_destroy();
			return;
		}

		Activity activity = opera_ads_get_activity();
		if (activity == null) return;

		mOperaAdsDisplayingAd = true;
		mAppOpenAd.show(activity, new AppOpenAdInteractionListener() {
			@Override
			public void onAdClicked() {
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Clicked.value());
			}

			@Override
			public void onAdDisplayed() {
				opera_ads_app_open_load();
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Displayed.value());
			}

			@Override
			public void onAdDismissed() {
				mOperaAdsDisplayingAd = false;
				opera_ads_app_open_destroy();
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Dismissed.value());
			}

			@Override
			public void onAdFailedToShow(@NonNull AdError error) {
				mOperaAdsDisplayingAd = false;
				opera_ads_app_open_destroy();
				if (mOpenAdsCallback != null)
					mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Failed.value(), error.getMessage());
			}
		});
	}

	private void opera_ads_app_open_destroy() {
		if (mAppOpenAd != null) {
			mAppOpenAd.destroy();
			mAppOpenAd = null;
		}
	}

	// -------------------------------------------------------------------------
	// Banner
	// -------------------------------------------------------------------------

	private BannerAdView mBannerAdView = null;
	private GMFunction mBannerLoadCallback = null;
	private OperaAdsBannerPosition mBannerPosition = OperaAdsBannerPosition.TopCenter;
	private int mBannerAutoRefreshInterval = 0;
	private ViewGroup mRootView = null;
	private FrameLayout.LayoutParams mBannerLayoutParams = null;
	private boolean mRootContainsBanner = false;
	private boolean mBannerLoaded = false;
	private boolean mBannerLoadedOnce = false;
	private boolean mBannerLoadInProgress = false;
	private boolean mBannerVisible = false;

	private AdSize bannerAdSize(OperaAdsBannerSize size) {
		switch (size) {
			case Banner:            return AdSize.BANNER;
			case BannerLarge:       return AdSize.BANNER_320x100;
			case BannerMREC:        return AdSize.BANNER_MREC;
			case BannerLeaderboard: return AdSize.BANNER_728x90;
			case BannerSmart:       return AdSize.BANNER;
			default:                return AdSize.BANNER_MREC;
		}
	}

	private int bannerPositionToGravity(OperaAdsBannerPosition position) {
		switch (position) {
			case TopLeft:      return Gravity.TOP    | Gravity.START;
			case TopCenter:    return Gravity.TOP    | Gravity.CENTER_HORIZONTAL;
			case TopRight:     return Gravity.TOP    | Gravity.END;
			case MiddleLeft:   return Gravity.CENTER_VERTICAL | Gravity.START;
			case MiddleCenter: return Gravity.CENTER;
			case MiddleRight:  return Gravity.CENTER_VERTICAL | Gravity.END;
			case BottomLeft:   return Gravity.BOTTOM | Gravity.START;
			case BottomCenter: return Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
			case BottomRight:  return Gravity.BOTTOM | Gravity.END;
		}
		return Gravity.TOP | Gravity.CENTER_HORIZONTAL;
	}

	public void opera_ads_banner_load(OperaAdsBannerSize size, GMFunction callback) {
		if (!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (mBannerPlacementId.isEmpty()) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), "Banner placement ID is empty.");
			return;
		}

		if (mBannerLoadedOnce) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), "Banner ad view has already been loaded. Destroy it before loading again.");
			return;
		}

		if (mBannerLoadInProgress) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), "Banner ad load is already in progress.");
			return;
		}

		Activity activity = opera_ads_get_activity();
		if (activity == null) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), "Current Android activity is unavailable.");
			return;
		}

		mBannerLoadInProgress = true;
		mBannerLoadCallback = callback;

		if (mBannerAdView == null) {
			mBannerAdView = new BannerAdView(activity);
		}

		mBannerAdView.setPlacementId(mBannerPlacementId);
		mBannerAdView.setAdSize(bannerAdSize(size));
		if (mBannerAutoRefreshInterval > 0) {
			mBannerAdView.setAutoRefreshInterval(mBannerAutoRefreshInterval);
		} else {
			mBannerAdView.setAutoRefreshEnabled(false);
		}
		mBannerAdView.loadAd(new BannerAdListener() {
			@Override
			public void onAdLoaded(@NonNull BannerAd bannerAd) {
				mBannerLoaded = true;
				mBannerLoadedOnce = true;
				mBannerLoadInProgress = false;
				mBannerLoadCallback.call(OperaAdsCallbackEventBanner.Loaded.value());
			}

			@Override
			public void onAdFailedToLoad(@NonNull AdError error) {
				mBannerLoaded = false;
				mBannerLoadInProgress = false;
				opera_ads_banner_destroy();
				mBannerLoadCallback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), error.getMessage());
			}

			@Override
			public void onAdImpression() {
				mBannerLoadCallback.call(OperaAdsCallbackEventBanner.Impression.value());
			}

			@Override
			public void onAdClicked() {
				mBannerLoadCallback.call(OperaAdsCallbackEventBanner.Clicked.value());
			}
		});
	}

	public boolean opera_ads_banner_is_ad_valid() {
		if (!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mBannerLoaded) return false;
		return !mBannerAdView.isAdInvalidated();
	}

	public boolean opera_ads_banner_show(OperaAdsBannerPosition position) {
		if (!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mBannerLoaded) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		Activity activity = opera_ads_get_activity();
		if (activity == null) return false;

		mBannerPosition = position;

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null) return;
			if (mBannerAdView.isAdInvalidated()) {
				opera_ads_banner_destroy();
				return;
			}

			mRootView = opera_ads_get_root_view(activity);
			if (mRootView == null) return;

			if (mBannerLayoutParams == null) {
				mBannerLayoutParams = new FrameLayout.LayoutParams(
					FrameLayout.LayoutParams.WRAP_CONTENT,
					FrameLayout.LayoutParams.WRAP_CONTENT
				);
			}

			mBannerLayoutParams.gravity = bannerPositionToGravity(mBannerPosition);

			ViewGroup parent = (ViewGroup) mBannerAdView.getParent();
			if (!mRootContainsBanner) {
				if (parent != null) parent.removeView(mBannerAdView);
				mRootView.addView(mBannerAdView, mBannerLayoutParams);
				mRootContainsBanner = true;
			} else {
				if (parent == null) {
					mRootContainsBanner = false;
					mRootView.addView(mBannerAdView, mBannerLayoutParams);
					mRootContainsBanner = true;
				}
				mBannerAdView.setLayoutParams(mBannerLayoutParams);
				mBannerAdView.requestLayout();
			}

			mBannerAdView.setVisibility(android.view.View.VISIBLE);
			mBannerAdView.bringToFront();
			mBannerVisible = true;
		});
		return true;
	}

	public boolean opera_ads_banner_move(OperaAdsBannerPosition position) {
		if (!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mRootContainsBanner) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		mBannerPosition = position;

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null || !mRootContainsBanner) return;

			if (mBannerLayoutParams == null) {
				mBannerLayoutParams = new FrameLayout.LayoutParams(
					FrameLayout.LayoutParams.WRAP_CONTENT,
					FrameLayout.LayoutParams.WRAP_CONTENT
				);
			}

			mBannerLayoutParams.gravity = bannerPositionToGravity(mBannerPosition);
			mBannerAdView.setLayoutParams(mBannerLayoutParams);
			mBannerAdView.requestLayout();
		});
		return true;
	}

	public boolean opera_ads_banner_destroy() {
		mBannerLoadInProgress = false;

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView != null) {
				ViewGroup parent = (ViewGroup) mBannerAdView.getParent();
				if (parent != null) parent.removeView(mBannerAdView);
				mBannerAdView.destroy();
				mBannerAdView = null;
			}

			mBannerLoaded = false;
			mBannerLoadedOnce = false;
			mBannerLoadInProgress = false;
			mBannerVisible = false;
			mRootContainsBanner = false;
			mBannerLayoutParams = null;
			mRootView = null;
		});
		return true;
	}

	public boolean opera_ads_banner_hide() {
		if (!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mRootContainsBanner) return false;
		if (!mBannerVisible) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null || !mRootContainsBanner) return;
			mBannerAdView.setVisibility(android.view.View.GONE);
			mBannerVisible = false;
		});
		return true;
	}

	public boolean opera_ads_banner_unhide() {
		if (!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mRootContainsBanner) return false;
		if (!mBannerLoaded) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null || !mRootContainsBanner) return;
			if (mBannerAdView.isAdInvalidated()) {
				opera_ads_banner_destroy();
				return;
			}
			mBannerAdView.setVisibility(android.view.View.VISIBLE);
			mBannerAdView.bringToFront();
			mBannerAdView.requestLayout();
			mBannerVisible = true;
		});
		return true;
	}

	public boolean opera_ads_banner_is_visible() {
		if (!mOperaAdsInitialized) return false;
		return mBannerVisible && mRootContainsBanner && mBannerAdView != null
			&& mBannerAdView.getVisibility() == android.view.View.VISIBLE;
	}

	// -------------------------------------------------------------------------
	// Lifecycle
	// -------------------------------------------------------------------------

	public void onPause() {
		if (!mOperaAdsInitialized) return;
		if (mBannerAdView != null) mBannerAdView.pause();
	}

	public void onResume() {
		if (!mOperaAdsInitialized) return;
		if (mBannerAdView != null) mBannerAdView.resume();

		if (!mOperaAdsDisplayingAd && opera_ads_app_open_is_enabled()) {
			if (opera_ads_app_open_is_ad_valid()) {
				opera_ads_app_open_show();
			} else {
				opera_ads_app_open_load();
			}
		}
	}

	public void onDestroy() {
		opera_ads_interstitial_destroy();
		opera_ads_rewarded_destroy();
		opera_ads_rewarded_interstitial_destroy();
		opera_ads_app_open_destroy();
		opera_ads_banner_destroy();

		mInterstitialLoadCallback = null;
		mInterstitialShowCallback = null;
		mRewardedLoadCallback = null;
		mRewardedShowCallback = null;
		mRewardedInterstitialLoadCallback = null;
		mRewardedInterstitialShowCallback = null;
		mOpenAdsCallback = null;
		mBannerLoadCallback = null;

		mOpenAdsPlacementId = "";
		mRootView = null;
		mBannerLayoutParams = null;
		mRootContainsBanner = false;
		mBannerLoaded = false;
		mBannerLoadedOnce = false;
		mBannerVisible = false;
		mOperaAdsDisplayingAd = false;
	}

}
