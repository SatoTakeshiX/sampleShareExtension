//
//  ViewController.m
//  sampleShareExtension
//
//  Created by satoutakeshi on 2015/08/04.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sampleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Shareで保存したデータ
    // 取り出し
    NSUserDefaults *sharedUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.personal-factory.sampleShareExtension"];
    NSString *username = [sharedUserDefaults stringForKey:@"username"];
    
    NSLog(@"Share Data : %@", username);
    
    self.sampleLabel.text = username;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
