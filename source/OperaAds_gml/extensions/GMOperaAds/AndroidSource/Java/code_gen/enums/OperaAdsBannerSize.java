// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsBannerSize
{
    Banner((int)0),
    BannerLarge((int)1),
    BannerMREC((int)2),
    BannerLeaderboard((int)3),
    BannerSmart((int)4);

    private final int value;
    private OperaAdsBannerSize(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsBannerSize from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsBannerSize.Banner;
            case 1:
                return OperaAdsBannerSize.BannerLarge;
            case 2:
                return OperaAdsBannerSize.BannerMREC;
            case 3:
                return OperaAdsBannerSize.BannerLeaderboard;
            case 4:
                return OperaAdsBannerSize.BannerSmart;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsBannerSize value: " + v);
        }
    }
}