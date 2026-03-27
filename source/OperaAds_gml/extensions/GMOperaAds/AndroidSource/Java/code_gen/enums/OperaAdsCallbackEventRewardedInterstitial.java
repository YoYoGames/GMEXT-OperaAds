// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsCallbackEventRewardedInterstitial
{
    Clicked((int)0),
    Displayed((int)1),
    Dismissed((int)2),
    Failed((int)3),
    Rewarded((int)4);

    private final int value;
    private OperaAdsCallbackEventRewardedInterstitial(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsCallbackEventRewardedInterstitial from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsCallbackEventRewardedInterstitial.Clicked;
            case 1:
                return OperaAdsCallbackEventRewardedInterstitial.Displayed;
            case 2:
                return OperaAdsCallbackEventRewardedInterstitial.Dismissed;
            case 3:
                return OperaAdsCallbackEventRewardedInterstitial.Failed;
            case 4:
                return OperaAdsCallbackEventRewardedInterstitial.Rewarded;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsCallbackEventRewardedInterstitial value: " + v);
        }
    }
}