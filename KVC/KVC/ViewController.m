//
//  ViewController.m
//  KVC
//
//  Created by 赵鹏 on 2019/5/8.
//  Copyright © 2019 赵鹏. All rights reserved.
//

/**
 1、KVC的全称是"Key-Value Coding"，俗称“键值编码”，可以通过一个key来访问对象的某个属性；
 2、KVC常见的API有：
 - (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
 - (void)setValue:(id)value forKey:(NSString *)key;
 - (id)valueForKeyPath:(NSString *)keyPath;
 - (id)valueForKey:(NSString *)key;
 */
#import "ViewController.h"
#import "ZPPerson.h"
#import "ZPCat.h"

@interface ViewController ()

@property (nonatomic, strong) ZPPerson *person;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.person = [[ZPPerson alloc] init];
    
    //用普通方式设置和获取属性值
//    [self commonSetAndFetchPropertyValue];
    
    //用KVC方式设置属性值
//    [self setPropertyValueWithKVC];
    
    //用KVC方式获取属性值
//    [self fetchPropertyValueWithKVC];
    
    //KVC触发KVO
    [self KVCTriggerKVO];
}

#pragma mark ————— 用普通方式设置和获取属性值 —————
- (void)commonSetAndFetchPropertyValue
{
    //一般通过如下的代码来调用对象属性的set和get方法，从而对对象的属性进行设置和获取。
    self.person.age = 10;
    NSLog(@"%d", self.person.age);
}

#pragma mark ————— 用KVC方式设置属性值 —————
- (void)setPropertyValueWithKVC
{
    /**
     ·除了调用属性的set和get方法来设置和获取对象的属性值之外，还可以通过KVC的方式来对对象的属性值进行设置；
     ·KVC中"setValue: forKey: "和"setValue: forKeyPath: "方法的相同点是都能对对象的直接属性进行设置，不同点是后者可以对对象的间接属性进行设置，而前者就不能了。
     */
//    [self.person setValue:[NSNumber numberWithInt:10] forKey:@"age"];
//    [self.person setValue:[NSNumber numberWithInt:10] forKeyPath:@"age"];
//    NSLog(@"%d", self.person.age);
    
    self.person.cat = [[ZPCat alloc] init];
    [self.person setValue:[NSNumber numberWithInt:10] forKeyPath:@"cat.weight"];
    NSLog(@"%d", self.person.cat.weight);
}

#pragma mark ————— 用KVC方式获取属性值 —————
- (void)fetchPropertyValueWithKVC
{
    self.person.age = 10;
    
    self.person.cat = [[ZPCat alloc] init];
    [self.person setValue:[NSNumber numberWithInt:20] forKeyPath:@"cat.weight"];
    
    /**
     ·除了通过调用属性的set和get方法来设置和获取对象的属性值之外，还可以通过KVC的方式来获取对象的属性值；
     ·"valueForKey: "和"valueForKeyPath: "方法的相同点是它们都能对对象的直接属性进行获取，不同点是后者可以对对象的间接属性进行获取，而前者就不能了。
     */
    NSLog(@"%@", [self.person valueForKey:@"age"]);
    NSLog(@"%@", [self.person valueForKeyPath:@"cat.weight"]);
}

#pragma mark ————— KVC触发KVO —————
//通过KVC方式修改对象的属性值会触发KVO的监听方法。
- (void)KVCTriggerKVO
{
    //添加KVO监听
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    //通过KVC方式修改对象的属性值
    [self.person setValue:[NSNumber numberWithInt:10] forKey:@"age"];
}

#pragma mark ————— 监听方法 —————
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"监听到%@的%@属性值改变了 - %@", object, keyPath, change);
}

- (void)dealloc
{
    //移除监听
    [self.person removeObserver:self forKeyPath:@"age"];
}

@end
