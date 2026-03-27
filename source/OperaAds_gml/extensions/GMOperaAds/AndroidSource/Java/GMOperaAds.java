package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.enums.*;

import ${YYAndroidPackageName}.GMExtWire;
import ${YYAndroidPackageName}.GMExtWire.GMFunction;
import ${YYAndroidPackageName}.GMExtWire.GMValue;
import ${YYAndroidPackageName}.GMExtUtils;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.app.Activity;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import com.opera.ads.AdError;
import com.opera.ads.OperaAds;
import com.opera.ads.initialization.OnSdkInitCompleteListener;
import com.opera.ads.initialization.SdkInitConfig;
import com.opera.ads.AdFormat;

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
import android.view.ViewGroup.LayoutParams;

import com.opera.ads.AdSize;
import android.view.Gravity;
import android.widget.FrameLayout;
import com.opera.ads.banner.BannerAd;
import com.opera.ads.banner.BannerAdListener;
import com.opera.ads.banner.BannerAdView;

public class GMOperaAds extends GMOperaAdsInternal {

	private Activity opera_ads_get_activity() {
		return RunnerActivity.CurrentActivity;
	}

	private ViewGroup opera_ads_get_root_view(Activity activity) {
		if (activity == null) return null;
		return activity.findViewById(android.R.id.content);
	}


	private boolean mOperaAdsInitialized = false;
	private boolean mOperaAdsDisplayingAd = false;

	private String mGdprConsentString = "";
	private boolean mGdprApplies = false;
	private String mUSPrivacyString = "";
	private boolean mCoppa = false;
	private String mInterstitialPlacementId = "";
	private String mRewardedPlacementId = "";
	private String mRewardedInterstitialPlacementId = "";
	private String mAppOpenPlacementId = "";
	private String mBannerPlacementId = "";
	private static final String ERR_NOT_INITIALIZED = "Opera Ads SDK is not initialized.";
	
	private SharedPreferences opera_ads_get_default_preferences() {
		Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) return null;
		return PreferenceManager.getDefaultSharedPreferences(currentActivity.getApplicationContext());
	}
	
	private void opera_ads_apply_privacy_options() {
		SharedPreferences prefs = opera_ads_get_default_preferences();
		if (prefs == null) return;
		SharedPreferences.Editor editor = prefs.edit();
		editor.putInt("IABTCF_gdprApplies", mGdprApplies ? 1 : 0);
		editor.putString("IABTCF_TCString", mGdprConsentString != null ? mGdprConsentString : "");
		editor.putString("IABUSPrivacy_String", mUSPrivacyString != null ? mUSPrivacyString : "");
		editor.putBoolean("opera_ads_coppa", mCoppa);
		editor.apply();
		
		opera_ads_try_invoke_privacy_manager("setCoppa", Integer.valueOf(mCoppa ? 1 : 0));
		if (mUSPrivacyString != null && !mUSPrivacyString.isEmpty()) {
			opera_ads_try_invoke_privacy_manager("setUSPrivacy", mUSPrivacyString);
		}
	}
	
	private void opera_ads_try_invoke_privacy_manager(String methodName, Object arg) {
		String[] classNames = new String[] {
			"com.opera.ads.privacy.PrivacyManager",
			"com.opera.ads.PrivacyManager"
		};
		for (String className : classNames) {
			try {
				Class<?> cls = Class.forName(className);
				if (arg instanceof Integer) {
					cls.getMethod(methodName, Integer.class).invoke(null, arg);
					return;
				}
				if (arg instanceof String) {
					cls.getMethod(methodName, String.class).invoke(null, arg);
					return;
				}
			} catch (Throwable ignored) {
			}
		}
	}
	public boolean opera_ads_init(GMFunction callback) { 

			String app_id = GMExtUtils.GetExtensionOption("GMOperaAds","Android Application Id");

			mInterstitialPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds","Android Interstitial");
			mRewardedPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds","Android Rewarded");
			mRewardedInterstitialPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds","Android Rewarded Interstitial");
			mAppOpenPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds","Android App Open");
			mBannerPlacementId = GMExtUtils.GetExtensionOption("GMOperaAds","Android Banner");
	
			mBannerVisible = false;
			opera_ads_apply_privacy_options();

			Activity currentActivity = opera_ads_get_activity();
			if (currentActivity == null) {
				callback.call(false, "Current Android activity is unavailable.");
				return false;
			}

			OperaAds.initialize(currentActivity,
					new SdkInitConfig.Builder(app_id)
							.publisherName("Opera")
							.build(),
					new OnSdkInitCompleteListener() {
						@Override
						public void onSuccess() {
							mOperaAdsInitialized = true;
							callback.call(true); 
						}

						@Override
						public void onError(@NonNull AdError error) {
							Log.e("DemoApplication", "Failed to init ad sdk: " + error.getMessage());
							callback.call(false,error.getMessage()); 
						}
					});
			
			return true; 
		}
		
		
		public boolean opera_ads_set_mute(boolean mute) { 
			if(!mOperaAdsInitialized) return false;
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
			SharedPreferences prefs = opera_ads_get_default_preferences();
			if (prefs == null) return "";
			return prefs.getString("IABTCF_TCString", "");
		}
		
		public boolean opera_ads_get_gdpr_applies() {
			SharedPreferences prefs = opera_ads_get_default_preferences();
			if (prefs == null) return false;
			return prefs.getInt("IABTCF_gdprApplies", 0) == 1;
		}
		
		public String opera_ads_get_us_privacy() {
			SharedPreferences prefs = opera_ads_get_default_preferences();
			if (prefs == null) return "";
			return prefs.getString("IABUSPrivacy_String", "");
		}
		
		public boolean opera_ads_get_coppa() {
			SharedPreferences prefs = opera_ads_get_default_preferences();
			if (prefs == null) return false;
			return prefs.getBoolean("opera_ads_coppa", false);
		}

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
		}

		public void opera_ads_banner_set_placement_id(String placement_id) {
			mBannerPlacementId = placement_id != null ? placement_id : "";
		}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	private InterstitialAd mInterstitialAd = null;
	public void opera_ads_interstitial_load(GMFunction callback) { 
		
		String placement_id = mInterstitialPlacementId;

		if(!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}
		
		RunnerActivity.ViewHandler.post(() -> {
			Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) {
			callback.call(false, "Current Android activity is unavailable.");
			return;
		}
		InterstitialAd.load(currentActivity, placement_id, new InterstitialAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull InterstitialAd ad) {
					mInterstitialAd = ad;
					callback.call(true);
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					callback.call(false,error.getMessage()); 
				}
			});
		});
	}
		
	public boolean opera_ads_interstitial_is_ad_valid() { 
		
		if(!mOperaAdsInitialized) return false;
		
        if (mInterstitialAd == null) 
				return false;
			
		return !mInterstitialAd.isAdInvalidated();
	}
	
	public void opera_ads_interstitial_show(GMFunction callback) { 
		
		if(!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}
		
		RunnerActivity.ViewHandler.post(() -> {
				
			if (mInterstitialAd != null) {
				if (mInterstitialAd.isAdInvalidated()) {
					opera_ads_interstitial_destroy();
					callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), "Interstitial ad is invalid.");
					return ;
				}
				
				mOperaAdsDisplayingAd = true;
				Activity currentActivity = opera_ads_get_activity();
			if (currentActivity == null) {
				callback.call(OperaAdsCallbackEventInterstitial.Failed.value(), "Current Android activity is unavailable.");
				return;
			}
			mInterstitialAd.show(currentActivity, new InterstitialAdInteractionListener() {
					@Override
					public void onAdClicked() {
						callback.call(OperaAdsCallbackEventInterstitial.Clicked.value());
					}

					@Override
					public void onAdDisplayed() {
						callback.call(OperaAdsCallbackEventInterstitial.Displayed.value());
					}

					@Override
					public void onAdDismissed() {
						callback.call(OperaAdsCallbackEventInterstitial.Dismissed.value());
						mOperaAdsDisplayingAd = false;
						opera_ads_interstitial_destroy();
					}

					@Override
					public void onAdFailedToShow(@NonNull AdError error) {
						callback.call(OperaAdsCallbackEventInterstitial.Failed.value(),error.getMessage());
						mOperaAdsDisplayingAd = false;
						opera_ads_interstitial_destroy();
					}
				});
			}
		});
	}	
	
		
	public boolean opera_ads_interstitial_destroy() {
		if (!mOperaAdsInitialized) return false;

		if (mInterstitialAd != null){
			mInterstitialAd.destroy();
			mInterstitialAd = null;
		}
		return true;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	private RewardedAd mRewardedAd = null;
	public void opera_ads_rewarded_load(GMFunction callback)
	{
		String placement_id = mRewardedPlacementId;

		if(!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}
		RunnerActivity.ViewHandler.post(() -> {
			Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) {
			callback.call(false, "Current Android activity is unavailable.");
			return;
		}
		RewardedAd.load(currentActivity, placement_id, new RewardedAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull RewardedAd ad) {
					mRewardedAd = ad;
					callback.call(true); 
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					callback.call(false,error.getMessage()); 
				}
			});
		});
	}
	
    public boolean opera_ads_rewarded_is_ad_valid()
	{
		if(!mOperaAdsInitialized) return false;
		
		if (mRewardedAd == null) return false;
		return !mRewardedAd.isAdInvalidated();
	}
	
    public void opera_ads_rewarded_show(GMFunction callback)
	{
		if(!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventRewarded.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}
		
        if (mRewardedAd != null) {
            if (mRewardedAd.isAdInvalidated()) {
                opera_ads_rewarded_destroy();
                callback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Rewarded ad is invalid.");
                return;
            }
			
			mOperaAdsDisplayingAd = true;
			RunnerActivity.ViewHandler.post(() -> {
				Activity currentActivity = opera_ads_get_activity();
				if (currentActivity == null) {
					callback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Current Android activity is unavailable.");
					return;
				}
				mRewardedAd.show(currentActivity, new RewardedAdInteractionListener() {
					@Override
					public void onAdClicked() {
						callback.call(OperaAdsCallbackEventRewarded.Clicked.value());
					}

					@Override
					public void onAdDisplayed() {
						callback.call(OperaAdsCallbackEventRewarded.Displayed.value());
					}

					@Override
					public void onAdDismissed() {
						mOperaAdsDisplayingAd = false;
						callback.call(OperaAdsCallbackEventRewarded.Dismissed.value());
						opera_ads_rewarded_destroy();
					}

					@Override
					public void onAdFailedToShow(@NonNull AdError error) {
						callback.call(OperaAdsCallbackEventRewarded.Failed.value(),error.getMessage());
						mOperaAdsDisplayingAd = false;
						opera_ads_rewarded_destroy();
					}

					@Override
					public void onUserRewarded(@NonNull RewardItem reward) {
						callback.call(OperaAdsCallbackEventRewarded.Rewarded.value(),reward.type,reward.amount);
					}
				});
			});
        } else {
			callback.call(OperaAdsCallbackEventRewarded.Failed.value(), "Rewarded ad is not loaded.");
        }
	}
    
	public boolean opera_ads_rewarded_destroy()
	{
		if (!mOperaAdsInitialized) return false;

        if (mRewardedAd != null) {
			mRewardedAd.destroy();
		}
        mRewardedAd = null;
		return true;
	}
    
		
//////////////////////////////////////////////////////////////////////////////////////////
	
	private RewardedInterstitialAd mRewardedInterstitialAd = null;
	public void opera_ads_rewarded_interstitial_load(GMFunction callback)
	{
		String placement_id = mRewardedInterstitialPlacementId;

		if(!mOperaAdsInitialized) {
			callback.call(false, ERR_NOT_INITIALIZED);
			return;
		}
		
		RunnerActivity.ViewHandler.post(() -> {
			Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) {
			callback.call(false, "Current Android activity is unavailable.");
			return;
		}
		RewardedInterstitialAd.load(currentActivity, placement_id, new RewardedInterstitialAdLoadListener() {
				@Override
				public void onAdLoaded(@NonNull RewardedInterstitialAd ad) {
					mRewardedInterstitialAd = ad;
					callback.call(true); 
				}

				@Override
				public void onAdFailedToLoad(@NonNull AdError error) {
					callback.call(false,error.getMessage()); 
				}
			});
		});
	}
	
    public boolean opera_ads_rewarded_interstitial_is_ad_valid()
	{
		if(!mOperaAdsInitialized) return false;
		
        if (mRewardedInterstitialAd == null)  
			return false;
		
        return !mRewardedInterstitialAd.isAdInvalidated();
	}

    public void opera_ads_rewarded_interstitial_show(GMFunction callback)
	{
		if(!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), ERR_NOT_INITIALIZED);
			return;
		}
		
        if (mRewardedInterstitialAd != null) {
            if (mRewardedInterstitialAd.isAdInvalidated()) {
                opera_ads_rewarded_interstitial_destroy();
                callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Rewarded interstitial ad is invalid.");
                return;
            }
			
			mOperaAdsDisplayingAd = true;
			RunnerActivity.ViewHandler.post(() -> {
				Activity currentActivity = opera_ads_get_activity();
				if (currentActivity == null) {
					callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Current Android activity is unavailable.");
					return;
				}
				mRewardedInterstitialAd.show(currentActivity, new RewardedInterstitialAdInteractionListener() {
					@Override
					public void onAdClicked() {
						callback.call(OperaAdsCallbackEventRewardedInterstitial.Clicked.value());
					}

					@Override
					public void onAdDisplayed() {
						callback.call(OperaAdsCallbackEventRewardedInterstitial.Displayed.value());
					}

					@Override
					public void onAdDismissed() {
						mOperaAdsDisplayingAd = false;
						callback.call(OperaAdsCallbackEventRewardedInterstitial.Dismissed.value());
						opera_ads_rewarded_interstitial_destroy();
					}

					@Override
					public void onAdFailedToShow(@NonNull AdError error) {
						callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(),error.getMessage()); 
						mOperaAdsDisplayingAd = false;
						opera_ads_rewarded_interstitial_destroy();
					}

					@Override
					public void onUserRewarded(@NonNull RewardItem reward) {
						callback.call(OperaAdsCallbackEventRewardedInterstitial.Rewarded.value(),reward.type,reward.amount);
					}
				});
			});
        } else {
			callback.call(OperaAdsCallbackEventRewardedInterstitial.Failed.value(), "Rewarded interstitial ad is not loaded.");
        }
	}
	
    public boolean opera_ads_rewarded_interstitial_destroy()
	{
		if (!mOperaAdsInitialized) return false;

        if (mRewardedInterstitialAd != null) {
			mRewardedInterstitialAd.destroy();
		}
        mRewardedInterstitialAd = null;
		return true;
	}
		
		
//////////////////////////////////////////////////////////////////////////////////////////


	private String mOpenAdsPlacementId = "";
	private GMFunction mOpenAdsCallback;
	public void opera_ads_app_open_enable(GMFunction callback){

		String placement_id = mAppOpenPlacementId;

		if(!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventAppOpen.LoadFailed.value(), ERR_NOT_INITIALIZED);
			return;
		}
		
		mOpenAdsPlacementId = placement_id;
		mOpenAdsCallback = callback;
		
		opera_ads_app_open_load();
	}
	
	public boolean opera_ads_app_open_disable() {
		if(!mOperaAdsInitialized) return false;
		
		mOpenAdsPlacementId = "";
		mOpenAdsCallback = null;
		mOperaAdsDisplayingAd = false;
		opera_ads_app_open_destroy();
		return true;
	}
		
	public boolean opera_ads_app_open_is_enabled() {
		if(!mOperaAdsInitialized) return false;
		
        return mOpenAdsPlacementId != null && !mOpenAdsPlacementId.isEmpty();
    }
	
	private AppOpenAd mAppOpenAd = null;
    private void opera_ads_app_open_load()
	{
		String placement_id = mAppOpenPlacementId;

		if(!mOperaAdsInitialized) return;
		
        Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) {
			Log.d("GMOperaAds", "App open load skipped: current Android activity is unavailable.");
			return;
		}
		AppOpenAd.load(currentActivity, placement_id, new AppOpenAdLoadListener() {
            @Override
            public void onAdLoaded(@NonNull AppOpenAd ad) {
                mAppOpenAd = ad;
				
				if(mOpenAdsCallback != null)
				mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Loaded.value());
            }

            @Override
            public void onAdFailedToLoad(@NonNull AdError error) {
				if(mOpenAdsCallback != null)
				mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.LoadFailed.value(),error.getMessage());
            }
        });
	}
	
    private boolean opera_ads_app_open_is_ad_valid()
	{
		if(!mOperaAdsInitialized) return false;
		
        if (mAppOpenAd == null) return false;
		return !mAppOpenAd.isAdInvalidated();
	}
	
    private void opera_ads_app_open_show()
	{
		if(!mOperaAdsInitialized) return;
		
        if (mAppOpenAd != null) {
            if (mAppOpenAd.isAdInvalidated()) {
                opera_ads_app_open_destroy();
                return;
            }
			
			mOperaAdsDisplayingAd = true;
            Activity currentActivity = opera_ads_get_activity();
			if (currentActivity == null) {
				Log.d("GMOperaAds", "App open show skipped: current Android activity is unavailable.");
				return;
			}
			mAppOpenAd.show(currentActivity, new AppOpenAdInteractionListener() {
                @Override
                public void onAdClicked() {
					if(mOpenAdsCallback != null)
						mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Clicked.value());
                }

                @Override
                public void onAdDisplayed() {
					opera_ads_app_open_load();
					if(mOpenAdsCallback != null)
						mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Displayed.value()); 
                }

                @Override
                public void onAdDismissed() {
                    mOperaAdsDisplayingAd = false;
                    opera_ads_app_open_destroy();
					if(mOpenAdsCallback != null)
						mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Dismissed.value()); 
                }

                @Override
                public void onAdFailedToShow(@NonNull AdError error) {
					mOperaAdsDisplayingAd = false;
					opera_ads_app_open_destroy();
					if(mOpenAdsCallback != null)
						mOpenAdsCallback.call(OperaAdsCallbackEventAppOpen.Failed.value(),error.getMessage()); 
                }
            });
        }
	}
	
    private void opera_ads_app_open_destroy()
	{
		if (mAppOpenAd != null) {
			mAppOpenAd.destroy();
		}
        mAppOpenAd = null;	
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	private OperaAdsBannerPosition mBannerPosition = OperaAdsBannerPosition.TopCenter;
	private ViewGroup mRootView = null;
	private FrameLayout.LayoutParams mBannerLayoutParams = null;
	private boolean mRootContainsBanner = false;

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

	
	private boolean mBannerLoaded = false;
	private boolean mBannerLoadedOnce = false;
	private boolean mBannerLoadInProgress = false;
	private boolean mBannerVisible = false;
	private BannerAdView mBannerAdView = null;
	public void opera_ads_banner_load(GMFunction callback)
	{
		String placement_id = mBannerPlacementId;

		if(!mOperaAdsInitialized) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), ERR_NOT_INITIALIZED);
			return;
		}

		if (placement_id == null || placement_id.isEmpty()) {
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

		Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) {
			callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(), "Current Android activity is unavailable.");
			return;
		}

        if (mBannerAdView == null) {
            mBannerAdView = new BannerAdView(currentActivity);
        }

        final BannerAdListener adListener = new BannerAdListener() {
            @Override
            public void onAdLoaded(@NonNull BannerAd bannerAd) {
				mBannerLoaded = true;
				mBannerLoadedOnce = true;
                callback.call(OperaAdsCallbackEventBanner.Loaded.value());
            }

            @Override
            public void onAdFailedToLoad(@NonNull AdError error) {
				mBannerLoaded = false;
				opera_ads_banner_destroy();
                callback.call(OperaAdsCallbackEventBanner.LoadFailed.value(),error.getMessage());
            }

            @Override
            public void onAdImpression() {
                callback.call(OperaAdsCallbackEventBanner.Impression.value());
            }

            @Override
            public void onAdClicked() {
                callback.call(OperaAdsCallbackEventBanner.Clicked.value());
            }
        };
        mBannerAdView.setPlacementId(placement_id);
        mBannerAdView.setAdSize(AdSize.BANNER_MREC);
        mBannerAdView.loadAd(adListener);
	}

	public boolean opera_ads_banner_is_ad_valid()
	{
		if(!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mBannerLoaded) return false;
		return !mBannerAdView.isAdInvalidated();
	}

	public boolean opera_ads_banner_show(OperaAdsBannerPosition position)
	{
		if(!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mBannerLoaded) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		Activity currentActivity = opera_ads_get_activity();
		if (currentActivity == null) return false;

		mBannerPosition = position;

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null) return;

			if (mBannerAdView.isAdInvalidated()) {
				opera_ads_banner_destroy();
				return;
			}

			mRootView = opera_ads_get_root_view(currentActivity);
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

    public boolean opera_ads_banner_move(OperaAdsBannerPosition position)
	{
		if(!mOperaAdsInitialized) return false;
		if (mBannerAdView == null) return false;
		if (!mRootContainsBanner) return false;
		if (mBannerAdView.isAdInvalidated()) {
			opera_ads_banner_destroy();
			return false;
		}

		mBannerPosition = position;

		RunnerActivity.ViewHandler.post(() -> {
			if (mBannerAdView == null) return;
			if (!mRootContainsBanner) return;

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

	public boolean opera_ads_banner_destroy()
	{
		if (!mOperaAdsInitialized) return false;

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

public boolean opera_ads_banner_is_visible()
{
    if(!mOperaAdsInitialized) return false;
    return mBannerVisible && mRootContainsBanner && mBannerAdView != null
            && mBannerAdView.getVisibility() == android.view.View.VISIBLE;
}


public boolean opera_ads_banner_hide()
{
    if(!mOperaAdsInitialized) return false;
    if (mBannerAdView == null) return false;
    if (!mRootContainsBanner) return false;
    if (!mBannerVisible) return false;
    if (mBannerAdView.isAdInvalidated()) {
        opera_ads_banner_destroy();
        return false;
    }

    RunnerActivity.ViewHandler.post(() -> {
        if (mBannerAdView == null) return;
        if (!mRootContainsBanner) return;

        mBannerAdView.setVisibility(android.view.View.GONE);
        mBannerVisible = false;
    });
    return true;
}


public boolean opera_ads_banner_unhide()
{
    if(!mOperaAdsInitialized) return false;
    if (mBannerAdView == null) return false;
    if (!mRootContainsBanner) return false;
    if (!mBannerLoaded) return false;

    if (mBannerAdView.isAdInvalidated()) {
        opera_ads_banner_destroy();
        return false;
    }

    RunnerActivity.ViewHandler.post(() -> {
        if (mBannerAdView == null) return;
        if (!mRootContainsBanner) return;

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

    public void onPause() {
		
		if(!mOperaAdsInitialized) return;
        if (mBannerAdView != null) mBannerAdView.pause();
    }

    
    public void onResume() {
		
		if(!mOperaAdsInitialized) return;
			
        if (mBannerAdView != null) mBannerAdView.resume();
		
		boolean show = false;
		if(!mOperaAdsDisplayingAd)
		{
			if(opera_ads_app_open_is_enabled())
			if(opera_ads_app_open_is_ad_valid())
				show = true;
			
			if(show)
				opera_ads_app_open_show();
			else
				opera_ads_app_open_load();
		}
		
	}

    
    public void onDestroy() {

		opera_ads_interstitial_destroy();
		opera_ads_rewarded_destroy();
		opera_ads_rewarded_interstitial_destroy();
		opera_ads_app_open_destroy();
		opera_ads_banner_destroy();

		mOpenAdsCallback = null;
		mOpenAdsPlacementId = "";

		mRootView = null;
		mBannerLayoutParams = null;
		mRootContainsBanner = false;
		mBannerLoaded = false;
		mBannerLoadedOnce = false;
		mBannerVisible = false;

		mOperaAdsDisplayingAd = false;
	}
	
	
	

	//////////////////////////////////////////////////////////////////////////////////////////
	public void opera_ads_rewarded_set_scene(String scene_id)
	{
		if(!mOperaAdsInitialized) return;
		if (mRewardedAd == null) return;
		mRewardedAd.setSceneId(scene_id);
	}
	
	public void opera_ads_rewarded_set_reward_ssv_options(String user_id,String custom_data)
	{
		if(!mOperaAdsInitialized) return;
		if (mRewardedAd == null) return;
		mRewardedAd.setRewardSsvOptions(new RewardSsvOptions.Builder()
				.userId(user_id)
				.customData(custom_data)
				.build());
	}
	
	public void opera_ads_rewarded_interstitial_set_scene(String scene_id)
	{
		if(!mOperaAdsInitialized) return;
		if (mRewardedInterstitialAd == null) return;
		mRewardedInterstitialAd.setSceneId(scene_id);
	}
	
	public void opera_ads_rewarded_interstitial_set_reward_ssv_options(String user_id,String custom_data)
	{
		if(!mOperaAdsInitialized) return;
		if (mRewardedInterstitialAd == null) return;
		mRewardedInterstitialAd.setRewardSsvOptions(new RewardSsvOptions.Builder()
				.userId(user_id)
				.customData(custom_data)
				.build());
	}

}
