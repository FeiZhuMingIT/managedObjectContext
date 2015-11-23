//
//  ViewController.m
//  08-managedObjectContext查询
//
//  Created by Alvechen on 15/11/23.
//  Copyright © 2015年 Alvechen. All rights reserved.
//

#import "ViewController.h"
#import "Person+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic,strong) NSManagedObjectContext  *managedObjectContext;

@end

@implementation ViewController

- (NSManagedObjectContext *)managedObjectContext{

    
    if (_managedObjectContext != nil) {
        return  _managedObjectContext;
    }
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    _managedObjectContext = delegate.managedObjectContext;

    return _managedObjectContext;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    Person *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    p1.name = @"张三";
    p1.age = @18;
    
//    [self.managedObjectContext save:NULL];
    
    
    Person *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    p2.name = @"李四张";
    p2.age = @19;
    
//    [self.managedObjectContext save:NULL];
    
    Person *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    p3.name = @"王五";
    p3.age = @23;
    
//    [self.managedObjectContext save:NULL];
    
    Person *p4 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    p4.name = @"张四";
    p4.age = @35;
    
//    [self.managedObjectContext save:NULL];
    
    Person *p5 = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    p5.name = @"赵六";
    p5.age = @20;
    
    
    [self.managedObjectContext save:NULL];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //使用苹果封装的一个代码块--- fetch..
    
    //查询请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //你要查询的实体
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    //将实体设置到查询请求
    [fetchRequest setEntity:entity];
    
    
    // 查询条件(谓词)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.name CONTAINS '张'"];
    [fetchRequest setPredicate:predicate];
    
    
    //排序描述器
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                                   ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    
    //执行查询请求-获得结果
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    if (fetchedObjects == nil) {
        
        
    }
    
    for (Person *p in fetchedObjects) {
        
        NSLog(@"%@",p.name);
    }

    

    
}

@end
