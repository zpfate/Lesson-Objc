//
//  MVPTableViewCell.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "MVPTableViewCell.h"

@interface MVPTableViewCell ()

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *minusBtn;

@end


@implementation MVPTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}



- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _numLabel;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
//        _addBtn.backgroundColor = []
    }
    return _addBtn;
}




@end
