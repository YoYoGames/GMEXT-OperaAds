## IMPORTANT

* This extension is compatible with **GameMaker 2023.1 and newer (LTS22+)**
* Target platforms: **Android / iOS**
* Android: **API 24+ (Android 7.0)** minimum, **API 34 (Android 14)** recommended
* iOS: **iOS 13+** minimum, requires **Xcode 16.4+**
* Requires **Opera Ads publisher account** and app registration
* **No manual SDK installation required** - GameMaker automatically pulls dependencies via Gradle (Android) and CocoaPods (iOS)

---

## CHANGES SINCE ${releaseOldVersion}

https://github.com/YoYoGames/GMEXT-OperaAds/compare/${releaseOldVersion}...${releaseNewVersion}

---

## DESCRIPTION

Opera Ads is an advertising platform that enables developers to monetize their applications through various ad formats. This extension integrates the Opera Ads SDK into GameMaker, providing a simple and efficient way to display ads and generate revenue from your games.

GameMaker’s build system automatically handles SDK dependency management - Gradle pulls the Android SDK (`com.opera:opera-ads`) and CocoaPods pulls the iOS SDK (`OpAdxSdk`) during the build process.

---

## FEATURES

* Support for multiple **ad formats**:
  * **Banner Ads** - Standard 320x50 and MREC 300x250 sizes
  * **Interstitial Ads** - Full-screen ads at natural break points
  * **Rewarded Video Ads** - User-watched videos with reward callbacks
  * **Native Ads** - Customizable layouts blending with your game
* **Easy-to-use GameMaker API** with async event callbacks
* **Cross-platform support** (Android and iOS)
* **COPPA and privacy compliance** support built-in
* **Event-driven system** for ad lifecycle (loaded, displayed, clicked, closed, rewarded)
* **Automatic dependency management** - no manual SDK installation needed
* Lightweight integration with minimal performance impact

---

## USAGE NOTES

* Requires an **Opera Ads publisher account** with registered app
* Obtain your **Application ID** and **Ad Unit IDs** from the Opera Ads publisher portal
* Ad availability depends on **user location and ad inventory**
* Follow best practices for ad placement:
  * Don’t force users to click ads
  * Show interstitials at natural breaks (level complete, game over)
  * Provide clear value exchange for rewarded ads
  * Respect user privacy and consent preferences
* Test thoroughly with **test mode** before production release
* Initialize the SDK early in your game lifecycle
* Ensure compliance with:
  * GDPR / CCPA regulations
  * COPPA requirements (if targeting children)
  * Platform-specific advertising policies

---

## SETUP REQUIREMENTS

* Register your app in the **Opera Ads publisher portal** at https://doc.adx.opera.com
* Obtain your **Application ID** and configure **Ad Unit IDs** for each ad format
* Add required permissions (automatically handled by the extension):
  * Android: Internet, network state, phone state
  * iOS: App Tracking Transparency (if targeting iOS 14.5+)
* Implement proper **consent management** for GDPR/CCPA compliance
* Configure COPPA settings if your app targets children
* GameMaker will automatically pull SDK dependencies during build

---

## DOCUMENTATION

The full API documentation is included in the extension package (included files), along with setup and implementation examples.

---