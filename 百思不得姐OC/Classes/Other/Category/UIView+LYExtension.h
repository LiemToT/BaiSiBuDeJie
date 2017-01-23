#import <UIKit/UIKit.h>

@interface UIView (LYExtension)
@property (nonatomic, assign) CGSize ly_size;
@property (nonatomic, assign) CGFloat ly_width;
@property (nonatomic, assign) CGFloat ly_height;
@property (nonatomic, assign) CGFloat ly_x;
@property (nonatomic, assign) CGFloat ly_y;
@property (nonatomic, assign) CGFloat ly_centerX;
@property (nonatomic, assign) CGFloat ly_centerY;

@property (nonatomic, assign) CGFloat ly_right;
@property (nonatomic, assign) CGFloat ly_bottom;

/** 获取Xib对应实例 */
+ (instancetype)ly_viewFromXib;

/** 判断View是否重叠 */
- (BOOL)intersectWithView:(UIView *)view;
@end
