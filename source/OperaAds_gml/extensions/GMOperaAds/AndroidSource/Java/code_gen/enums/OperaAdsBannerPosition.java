// ##### extgen :: Auto-generated file do not edit!! #####

package ${YYAndroidPackageName}.enums;

public enum OperaAdsBannerPosition
{
    TopLeft((int)0),
    TopCenter((int)1),
    TopRight((int)2),
    MiddleLeft((int)3),
    MiddleCenter((int)4),
    MiddleRight((int)5),
    BottomLeft((int)6),
    BottomCenter((int)7),
    BottomRight((int)8);

    private final int value;
    private OperaAdsBannerPosition(int v)
    {
        this.value = v;
    }
    public int value()
    {
        return this.value;
    }
    public static OperaAdsBannerPosition from(int v)
    {
        switch (v)
        {
            case 0:
                return OperaAdsBannerPosition.TopLeft;
            case 1:
                return OperaAdsBannerPosition.TopCenter;
            case 2:
                return OperaAdsBannerPosition.TopRight;
            case 3:
                return OperaAdsBannerPosition.MiddleLeft;
            case 4:
                return OperaAdsBannerPosition.MiddleCenter;
            case 5:
                return OperaAdsBannerPosition.MiddleRight;
            case 6:
                return OperaAdsBannerPosition.BottomLeft;
            case 7:
                return OperaAdsBannerPosition.BottomCenter;
            case 8:
                return OperaAdsBannerPosition.BottomRight;
            default:
                throw new IllegalArgumentException("Unknown OperaAdsBannerPosition value: " + v);
        }
    }
}