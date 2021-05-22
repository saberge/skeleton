//
//  ZMKSkeletonPlayer.m
//  ZMKUIKit
//
//  Created by laixian on 2021/5/20.
//

#import "ZZSkeletonPlayer.h"
#import <WebKit/WebKit.h>
#import "Masonry.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface ZZSkeletonPlayer()
@property (nonatomic ,strong) WKWebView *webPlayer;
@property (nonatomic ,strong) void(^playerCompleted)(void);
@property (nonatomic ,strong) WebViewJavascriptBridge *bridge;
@end


@implementation ZZSkeletonPlayer

+ (instancetype)playerSkeletonInContainer:(UIView *)container completedBlock:(nonnull void (^)(void))completedBlock
{
    NSParameterAssert(container);
    NSString *skeletonDirectory = [[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle",@"skeleton"]] stringByAppendingPathComponent:@"defaultSkeleton"];
    ZZSkeletonPlayer *player = [ZZSkeletonPlayer new];
    [container addSubview:player];
    [player mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [player addSubview:player.webPlayer];
    [player.webPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [player.webPlayer loadFileURL:[NSURL fileURLWithPath:[skeletonDirectory stringByAppendingPathComponent:@"skeleton.html"]] allowingReadAccessToURL:[NSURL fileURLWithPath:skeletonDirectory]];
    [player.bridge registerHandler:@"animationCompleted" handler:^(id data, WVJBResponseCallback responseCallback) {
        [player removeFromSuperview];
        if (completedBlock) completedBlock();

    }];
    return  player;
}

- (WKWebView *)webPlayer
{
    if (!_webPlayer) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        WKPreferences *pre = [WKPreferences new];
        [pre setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
        config.preferences = pre;
        _webPlayer = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        _webPlayer.backgroundColor = UIColor.clearColor;
    }
    return _webPlayer;
}

- (WebViewJavascriptBridge *)bridge
{
    if (!_bridge) {
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self.webPlayer];
    }
    return _bridge;
}
@end
