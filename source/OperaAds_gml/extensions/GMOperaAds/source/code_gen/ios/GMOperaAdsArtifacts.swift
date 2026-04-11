public enum OperaAdsCallbackEventInterstitial: UInt32
{
    case Clicked = 0
    case Displayed = 1
    case Dismissed = 2
    case Failed = 3
}

public enum OperaAdsCallbackEventRewarded: UInt32
{
    case Clicked = 0
    case Displayed = 1
    case Dismissed = 2
    case Failed = 3
    case Rewarded = 4
}

public enum OperaAdsCallbackEventRewardedInterstitial: UInt32
{
    case Clicked = 0
    case Displayed = 1
    case Dismissed = 2
    case Failed = 3
    case Rewarded = 4
}

public enum OperaAdsCallbackEventAppOpen: UInt32
{
    case Loaded = 0
    case LoadFailed = 1
    case Clicked = 2
    case Displayed = 3
    case Dismissed = 4
    case Failed = 5
}

public enum OperaAdsCallbackEventBanner: UInt32
{
    case Loaded = 0
    case LoadFailed = 1
    case Impression = 2
    case Clicked = 3
}

public enum OperaAdsBannerPosition: UInt32
{
    case TopLeft = 0
    case TopCenter = 1
    case TopRight = 2
    case MiddleLeft = 3
    case MiddleCenter = 4
    case MiddleRight = 5
    case BottomLeft = 6
    case BottomCenter = 7
    case BottomRight = 8
}

public enum OperaAdsBannerSize: UInt32
{
    case Banner = 0
    case BannerLarge = 1
    case BannerMREC = 2
    case BannerLeaderboard = 3
    case BannerSmart = 4
}

