//
//  WebViewController.m
//  Final Assignment
//
//  Created by Xcode User on 2017-04-16.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

//AUTHOR:Patrick Simmons
//This class is to view a web view that goes to a website that can help a user understand some music theory

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize wbPage, activity;

//This method allows for when the web view has started loading to have the activity indicator to start animating
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activity setHidden:NO];
    [activity startAnimating];
}

//This method allows for when the web view has finished loading to have the activity indicator to stop animating and to disappear
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activity setHidden:YES];
    [activity stopAnimating];
}

//This method is for when the view loads to get the web view to go to the specified url
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *urlAddress = [NSURL URLWithString:@"http://www.mixingguide.com/pitch-tempo-and-key"];
    NSURLRequest *url = [NSURLRequest requestWithURL:urlAddress];
    [wbPage loadRequest:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
