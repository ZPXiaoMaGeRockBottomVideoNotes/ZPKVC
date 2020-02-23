//
//  ZPPerson.m
//  KVC
//
//  Created by 赵鹏 on 2019/5/8.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "ZPPerson.h"

@implementation ZPPerson

- (void)setAge:(int)age
{
    _age = age;
    
    NSLog(@"setAge - %d", age);
}

@end
