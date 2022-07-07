//
//  FSViewController.m
//  FSOCNetworking
//
//  Created by 张忠燕 on 06/30/2022.
//  Copyright (c) 2022 张忠燕. All rights reserved.
//

#import "FSViewController.h"
#import "FSHTTPClient+FSClient.h"
#import <FSOCUtils/FSSafeUtils.h>
#import "FSUserInfoEntity.h"
#import "FSFileRespEntity.h"

@interface FSViewController ()

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params safeSetObject:@"11" forKey:@"userId"];
    
    //@weakify(self);
    //[MBProgressHUD showLoadingInView:self.view];
    [[FSHTTPClient shared] postRequestWithUrl:@"api/userInfo" parameters:params entityClass:FSUserInfoEntity.class complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
        //@strongify(self);
        //[MBProgressHUD hidenLoadingInView:self.view];

        if (data.isSuccess) {
            //处理数据、刷新界面
            //[self.viewModel handleData:data.modelObject];
            //[self.tableView reaload];
        } else {
            //[MBProgressHUD showToastMessage:data.errMsg];
        }
    }];
    
    NSData *imageData = [NSData data];
    NSString *fileName = [NSString stringWithFormat:@"%ld_iOS.jpg", (long)[[NSDate date] timeIntervalSince1970] * 1000];;
    
    //@weakify(self);
    //[MBProgressHUD showLoadingInView:self.view];
    [[FSHTTPClient shared] postRequestWithUrl:@"api/file/upload" parameters:params entityClass:FSFileRespEntity.class constructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"files[0].file" fileName:fileName mimeType:@"image/jpeg"];
    } complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
        //@strongify(self);
        //[MBProgressHUD hidenLoadingInView:self.view];
        if (data.isSuccess) {
            //处理数据、刷新界面
            //[self.viewModel handleData:data.modelObject];
            //[self.tableView reaload];
        } else {
            //[MBProgressHUD showToastMessage:data.errMsg];
        }
    }];
    
    NSString *resumableDownloadPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"临时文件名"];
    
    //@weakify(self);
    //[MBProgressHUD showLoadingInView:self.view];
    [[FSHTTPClient shared] postDownloadFileWithURL:@"api/file/down" parameters:params resumableDownloadPath:resumableDownloadPath complateBlock:^(FSNetworkData * _Nonnull data, __kindof FSBaseRequest * _Nonnull request) {
        //@strongify(self);
        //[MBProgressHUD hidenLoadingInView:self.view];
        if (data.isSuccess) {
            //处理数据、刷新界面
            //[self.viewModel handleData:data.modelObject];
            //[self.tableView reaload];
        } else {
            //[MBProgressHUD showToastMessage:data.errMsg];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
