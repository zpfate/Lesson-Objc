//
//  QuadraticSolution.m
//  SolutionDemo
//
//  Created by Twisted Fate on 2022/7/18.
//

#import "QuadraticSolution.h"

@implementation QuadraticSolution

+ (void)start {
    
    printf("一元二次方程ax²+bx+c=0 \n");
    float a, b, c;
    input: printf("请输入a, b, c \n");
    scanf("%f %f %f", &a, &b, &c);
    if (a == 0) {
        NSLog(@"输入有误, a不能为0!!! \n");
        goto input;
    } else {
     
        float delta = pow(b, 2) - 4 * a * c;
        [self caculateX:a b:b delta:delta];
    }
}

+ (void)caculateX:(float)a b:(float)b delta:(float)delta {
    
    if (delta >= 0) {
        // 该方程有两个解
        float x1 = (-b + sqrt(delta)) / (2 * a);
        float x2 = (-b - sqrt(delta)) / (2 * a);
        printf("x1 = %.2f, x2 = %.2f \n", x1, x2);
        
    } else {
        // 该方程无实数根
        float real = -b / (2 * a);
        float imaginary = sqrt(fabs(delta)) / (2 * a);
        printf("x1 = %.2f + %.2fi, x2 = %.2f - %.2fi \n", real, fabs(imaginary), real, fabs(imaginary));
    }
}


@end
