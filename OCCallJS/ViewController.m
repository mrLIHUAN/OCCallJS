//
//  ViewController.m
//  OCCallJS
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UIWebViewDelegate,JSCallOCWithArgumentsDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)JSContext *jscontext;
@property(nonatomic,strong)JSObjCModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.scalesPageToFit = YES;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jscontext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _model = [[JSObjCModel alloc]init];
    _model.delegate = self;
    self.jscontext[@"OCModel"] = _model;
    _model.jsContext = self.jscontext;
    self.jscontext.exceptionHandler = ^(JSContext *context,JSValue *exceptionValue){
        context.exception = exceptionValue;
       NSLog(@"异常信息：%@", exceptionValue);
    };
}
#pragma mark -- JSCallOCWithArgumentsDelegate
-(void)JSCallOCWithArguments:(NSDictionary *)params isAlert:(BOOL)isAlert{

    NSLog(@"有参数+++++++\n%@",params);
    
    if (isAlert) {
        
        NSString *title = params[@"title"];
        NSString *msg = params[@"alert"];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [a show];
        });
    }else{
        NSDictionary *dic = @{@"age": @10, @"name": @"lili", @"height": @158};
        
        [_model OCCallJSWithMethodName:@"jsParamFunc" Arguments:dic isparams:YES];
    }
}

-(void)JSCallOCWithNoneArguments{
    NSLog(@"没有参数");
    
//    [_model OCCallJSWithMethodName:@"jsFunc" Arguments:nil isparams:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
