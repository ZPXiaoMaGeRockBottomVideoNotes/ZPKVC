//
//  ZPPerson.h
//  KVC
//
//  Created by 赵鹏 on 2019/5/8.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZPCat.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZPPerson : NSObject

@property (nonatomic, assign) int age;
@property (nonatomic, strong) ZPCat *cat;

@end

NS_ASSUME_NONNULL_END
