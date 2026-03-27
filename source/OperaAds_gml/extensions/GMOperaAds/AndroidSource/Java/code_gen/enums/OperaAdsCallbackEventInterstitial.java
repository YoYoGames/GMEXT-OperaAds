// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsCallbackEventInterstitial
{
    Clicked((int)0),
    Displayed((int)1),
    Dismissed((int)2),
    Failed((int)3);

    private final int value;
    private OperaAdsCallbackEventInterstitial(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsCallbackEventInterstitial from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsCallbackEventInterstitial.Clicked;
            case 1:
                return OperaAdsCallbackEventInterstitial.Displayed;
            case 2:
                return OperaAdsCallbackEventInterstitial.Dismissed;
            case 3:
                return OperaAdsCallbackEventInterstitial.Failed;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsCallbackEventInterstitial value: " + v);
        }
    }
}