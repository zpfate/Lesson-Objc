//
//  StoryBoardExtension.h
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoryboardExtension : NSObject

+ (UIViewController *)initialViewController:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
