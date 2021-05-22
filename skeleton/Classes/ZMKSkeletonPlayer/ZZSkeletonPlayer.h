//
//  ZMKSkeletonPlayer.h
//  ZMKUIKit
//
//  Created by laixian on 2021/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZSkeletonPlayer : UIView

/// webview+skeleton
/// @param container 容器视图，动画自动充满整个容器
/// @param skeletionDirectory 龙骨动画目录，如果为空使用默认的龙骨动画
/// @param completedBlock 动画完成回调
+ (instancetype )playerSkeletonInContainer:(UIView *)container
                            completedBlock:(void(^)(void))completedBlock;

@end

NS_ASSUME_NONNULL_END
