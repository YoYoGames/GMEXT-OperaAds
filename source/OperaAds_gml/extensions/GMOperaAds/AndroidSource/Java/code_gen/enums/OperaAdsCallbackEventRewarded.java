// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsCallbackEventRewarded
{
    Clicked((int)0),
    Displayed((int)1),
    Dismissed((int)2),
    Failed((int)3),
    Rewarded((int)4);

    private final int value;
    private OperaAdsCallbackEventRewarded(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsCallbackEventRewarded from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsCallbackEventRewarded.Clicked;
            case 1:
                return OperaAdsCallbackEventRewarded.Displayed;
            case 2:
                return OperaAdsCallbackEventRewarded.Dismissed;
            case 3:
                return OperaAdsCallbackEventRewarded.Failed;
            case 4:
                return OperaAdsCallbackEventRewarded.Rewarded;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsCallbackEventRewarded value: " + v);
        }
    }
}