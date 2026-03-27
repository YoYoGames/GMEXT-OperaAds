// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsCallbackEventAppOpen
{
    Loaded((int)0),
    LoadFailed((int)1),
    Clicked((int)2),
    Displayed((int)3),
    Dismissed((int)4),
    Failed((int)5);

    private final int value;
    private OperaAdsCallbackEventAppOpen(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsCallbackEventAppOpen from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsCallbackEventAppOpen.Loaded;
            case 1:
                return OperaAdsCallbackEventAppOpen.LoadFailed;
            case 2:
                return OperaAdsCallbackEventAppOpen.Clicked;
            case 3:
                return OperaAdsCallbackEventAppOpen.Displayed;
            case 4:
                return OperaAdsCallbackEventAppOpen.Dismissed;
            case 5:
                return OperaAdsCallbackEventAppOpen.Failed;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsCallbackEventAppOpen value: " + v);
        }
    }
}