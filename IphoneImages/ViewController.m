//
//  ViewController.m
//  IphoneImages
//
//  Created by Jun Oh on 2019-01-24.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView* iPhoneImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView* iPhoneImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    iPhoneImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iPhoneImageView];
    self.iPhoneImageView = iPhoneImageView;
    [iPhoneImageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [iPhoneImageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [iPhoneImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [iPhoneImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    
    
    
    UIButton* changeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [changeButton setTitle:@"CHANGE" forState:UIControlStateNormal];
    [changeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.view addSubview:changeButton];
    [changeButton addTarget:self action:@selector(changeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) sendRequest:(NSString*)urlString {
    NSURL *url = [NSURL URLWithString:urlString]; // 1
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.iPhoneImageView.image = image; // 4
        }];
    }]; // 4
    
    [downloadTask resume]; // 5
}

- (void) changeButtonPressed:(UIButton *)sender {
    
    NSArray<NSString*>* stringArray = @[@"http://imgur.com/bktnImE.png",
    @"http://imgur.com/zdwdenZ.png",
    @"http://imgur.com/CoQ8aNl.png",
    @"http://imgur.com/2vQtZBb.png",
                                        @"http://imgur.com/y9MIaCS.png"];
    [self sendRequest: stringArray[arc4random_uniform(5)]];
}


@end
