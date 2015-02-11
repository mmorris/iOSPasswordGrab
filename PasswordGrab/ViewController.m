//
//  ViewController.m
//  PasswordGrab
//
//  Created by Matthew Morris on 9/25/14.
//  Copyright (c) 2014 Matthew Morris. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, assign) NSUInteger imageCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageCount = 0;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.view = self.webView;
    
    NSURLRequest* urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.twitter.com"]];
    
    [self.webView loadRequest:urlRequest];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                          repeats:YES];
}

-(void)timerFired:(NSTimer*)theTimer
{
    NSLog(@"fired");
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* pathComponent = [NSString stringWithFormat:@"Image%lu.png", (unsigned long) self.imageCount];
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:pathComponent];
    
    [UIImagePNGRepresentation(resultingImage) writeToFile:filePath atomically:YES];
    UIGraphicsEndImageContext();
    
    self.imageCount = self.imageCount + 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end