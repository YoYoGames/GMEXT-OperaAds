#import "GMOperaAds_ios.h"
#import <UIKit/UIKit.h>

@implementation GMOperaAds
@end

extern UIView *g_glView;

extern "C" UIView* GMOperaAds_getGLView(void) {
    return g_glView;
}
