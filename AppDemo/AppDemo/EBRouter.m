//
//  EBRouter.m
//  AppDemo
//
//  Created by Twisted Fate on 2023/8/13.
//

#import "EBRouter.h"

NSString *const follow = @"/main/follow";
NSString *const stockDetail = @"/stock/detail";
NSString *const mainAsset = @"/main/asset";
NSString *const messageCenter = @"/me/message";
NSString *const assetDetail = @"/asset/assetDetail";
NSString *const meAbout = @"/me/about";
NSString *const versionInfo = @"/update/info";
NSString *const myProfile = @"/me/profile";

@implementation EBRouter

+ (BOOL)openURL:(NSString *)url {
    
    if ([url hasPrefix:@"http"]) {
        /// 直接打开webview
        return YES;
    }
    
    NSArray<NSString *> *urlCompoments = [url componentsSeparatedByString:@"?"];
    
    /// 取出URL的scheme用于跳转
    NSString *scheme = urlCompoments.firstObject;
    
    /// 格式化URL
    NSMutableDictionary *arguments = [NSMutableDictionary dictionary];
    if (urlCompoments.count == 2) {
        /// 如果有参数
        NSArray *params = [urlCompoments.lastObject componentsSeparatedByString:@"&"];
        for (NSString *keyValueStr in params) {
            NSArray *keyValue = [keyValueStr componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                [arguments setValue:keyValue.lastObject forKey:keyValue.firstObject];
            } else {
                return NO;
            }
        }
    }
    
    NSString *schemeUppercase = scheme.uppercaseString;
    if ([schemeUppercase isEqualToString:follow.uppercaseString]) {
        /// 自选
        
        
    } else if ([schemeUppercase isEqualToString:stockDetail.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:mainAsset.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:messageCenter.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:assetDetail.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:meAbout.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:versionInfo.uppercaseString]) {
        
    } else if ([schemeUppercase isEqualToString:myProfile.uppercaseString]) {
        
    }
//    else if ([schemeUppercase isEqualToString:stockDetail.uppercaseString]) {
//
//    }
    
    
    
    return NO;
}


+ (void)jumpToPage:(NSString *)url arguments:(NSDictionary *)arguments {
    
}

@end
