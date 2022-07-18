//
//  TFWebManager.h
//  WebViewDemo
//
//  Created by Twisted Fate on 2022/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFWebManager : NSObject

+ (instancetype)manager;

- (void)loadH5:(NSString *)url inViewController:(UIViewController *)vc;


- (void)dispose;

@end

NS_ASSUME_NONNULL_END
