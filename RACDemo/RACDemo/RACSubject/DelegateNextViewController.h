//
//  DelegateNextViewController.h
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface DelegateNextViewController : UIViewController

@property (nonatomic, strong) RACSubject *subject;

@end

NS_ASSUME_NONNULL_END
