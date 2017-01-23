//
//  LYWebViewController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/7.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYWebViewController.h"

@interface LYWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@end

@implementation LYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)back
{
    [self.webView goBack];
}

- (IBAction)forward
{
    [self.webView goForward];
}

- (IBAction)refresh
{
    self.refreshButton.enabled = false;
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.refreshButton.enabled = true;
    self.backButton.enabled = webView.canGoBack;
    self.forwardButton.enabled = webView.canGoForward;
}
@end






