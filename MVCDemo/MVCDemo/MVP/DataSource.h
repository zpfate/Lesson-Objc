//
//  DataSource.h
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Present;
@class MVPTableViewCell;

@protocol DataSourceDelegate <NSObject>

- (void)didClickNum:(NSString *)num indexPath:(NSIndexPath *)indexPath;

@end


@interface DataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak) id<DataSourceDelegate> delegate;

- (instancetype)initWithReuseIdentifer:(NSString *)reuseIdentifer configureBlock:(void(^)(MVPTableViewCell *cell, NSIndexPath *indexPath))configureBlock;

- (void)bindPresent:(Present *)present;

@end

NS_ASSUME_NONNULL_END
