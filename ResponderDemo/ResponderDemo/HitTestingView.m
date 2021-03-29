//
//  HitTestingView.m
//  ResponderDemo
//
//  Created by Twisted Fate on 2021/3/29.
//

#import "HitTestingView.h"

@implementation HitTestingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 无法响应事件
       if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
      // 触摸点若不在当前视图上则无法响应事件
      if ([self pointInside:point withEvent:event] == NO) return nil;
      // 倒序遍历
      int count = (int)self.subviews.count;
      for (int i = count - 1; i >= 0; i--) {
          // 获取子视图
          UIView *childView = self.subviews[i];
          // 坐标系的转换， 把触摸点在当前视图上坐标转换为在子视图上的坐标
          CGPoint childPoint = [self convertPoint:point toView:childView];
          // 询问子视图层级中的最佳响应视图
          UIView *responder = [childView hitTest:childPoint withEvent:event];
          if (responder) {
              // 如果子视图中有更合适的就返回
              return responder;
          }
      }
      // 子视图中没有找到合适的，返回自身
      return self;
}

@end
