// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsCallbackEventBanner
{
    Loaded((int)0),
    LoadFailed((int)1),
    Impression((int)2),
    Clicked((int)3);

    private final int value;
    private OperaAdsCallbackEventBanner(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsCallbackEventBanner from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsCallbackEventBanner.Loaded;
            case 1:
                return OperaAdsCallbackEventBanner.LoadFailed;
            case 2:
                return OperaAdsCallbackEventBanner.Impression;
            case 3:
                return OperaAdsCallbackEventBanner.Clicked;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsCallbackEventBanner value: " + v);
        }
    }
}