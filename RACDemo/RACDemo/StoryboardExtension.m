//
//  StoryBoardExtension.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "StoryboardExtension.h"

@implementation StoryboardExtension


+ (UIViewController *)initialViewController:(NSString *)identifier {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyBoard instantiateViewControllerWithIdentifier:identifier] ?: [UIViewController new];
}


@end
