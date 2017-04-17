//
//  WebViewController.h
//  Final Assignment
//
//  Created by Xcode User on 2017-04-16.
//  Copyright © 2017 Travis Terry & Patrick Simmons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *wbPage;
    IBOutlet UIActivityIndicatorView *activity;
}
@property (nonatomic, strong) IBOutlet UIWebView *wbPage;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activity;

@end
