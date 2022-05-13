//
//  ViewController.m
//  DragCollectionView
//
//  Created by Twisted Fate on 2022/5/9.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *sections;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:@"1",@"2", @"3", @"4", @"5", @"6",nil];
    
    NSMutableArray *section2 = [NSMutableArray arrayWithObjects:@"7", @"8", @"9", @"10", @"11", @"12", nil];
    
    self.sections = @[section1, section2];
    
    
    [self.view addSubview:self.collectionView];
    self.collectionView.editing = YES;
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:_collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
        //移动过程中更新位置坐标
            [_collectionView updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
        //停止移动调用此方法
            [_collectionView endInteractiveMovement];
            break;
        default:
        //取消移动
            [_collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.minimumLineSpacing = 10.f;
        layout.minimumInteritemSpacing = 10.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_collectionView addGestureRecognizer:longPress];
    }
    return _collectionView;
}


@end
