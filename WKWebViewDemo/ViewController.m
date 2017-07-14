//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by DBC on 16/9/6.
//  Copyright © 2016年 DBC. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSMessageHandle.h"
@interface ViewController ()<WKNavigationDelegate, JSMessageHandleDelegate>
@property (nonatomic, strong) JSContext *context;
@end

@implementation ViewController{
    WKWebView *_webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    // window.webkit.messageHandlers.<name>.postMessage(<messageBody>) for all    DbcInterface .jsCallJava(
    // document.writeln("<script language='javascript' src='en.js' ></script>");
    
    // 声明对象 方法 创建方法回调  适用dbc61 网页
//    NSString *source = @"var DbcInterface={}; DbcInterface.jsCallJava=function(a,b){window.webkit.messageHandlers.message.postMessage('{\"'+a+'\":\"'+b+'\"}')}";
    
    // 适用当前demo本地html
    NSString *source = @"var appObj={}; appObj.jsGetAppToken=function(){window.webkit.messageHandlers.message.postMessage('{\"type\":\"getToken\"}')}; appObj.createOrder=function(a){window.webkit.messageHandlers.message.postMessage('{\"type\":\"createOrder\", \"orderId\":'+a+'}')}";
    
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [userContentController addUserScript:userScript];
    
    JSMessageHandle *messageHandle = [[JSMessageHandle alloc] init];
    messageHandle.delegate = self;
    [userContentController addScriptMessageHandler:messageHandle name:@"message"];
    
    config.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.navigationDelegate = self;
    
//    NSString *url = @"http://juzilab.com/form";
//    NSString *url = @"http://www.dbc61.com/store/html/storeApply.html?user_id=3A7D736B2AAC0270E0530A6464A6EC9F&customer_id=54971&dynamic_id=0e2db390c1ec49db928d1bbdeedbea0a";
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_webView loadRequest:request];
//
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"jsMessage.html" ofType:nil];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:nil];
    
    [self.view addSubview:_webView];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    
    NSURL *actionURL = navigationResponse.response.URL;
    NSString *actionAbsoluteString = [actionURL absoluteString];
    NSLog(@"%@", actionAbsoluteString);
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}


#pragma mark -------- delegate
-(void)addNewElement:(NSString *)element{
    NSString *newELement = [NSString stringWithFormat:@"Form app call back:%@", element];
    NSString *javaScript = [NSString stringWithFormat:@"addNewElement('%@')", newELement];
    
    [_webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
