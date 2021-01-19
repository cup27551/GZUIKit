//
//  GZPhoneImageManager.m
//  CatPaw
//
//  Created by quark on 2020/7/21.
//  Copyright © 2020 BZDGuanZi. All rights reserved.
//

#import "GZPhotoImageManager.h"
#import <TZImagePickerController.h>

@interface GZPhotoImageManager () <TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UIViewController *keyVC;

@property (strong, nonatomic) CLLocation *location;


@end

@implementation GZPhotoImageManager

- (void)showImageActionFromController:(UIViewController *)controller {
    WEAKSELF;
    self.keyVC = controller;
    CommonAlertView *sheetView = [CommonAlertView sheetAlertViewWithTitles:@[@"相册",@"相机"] cancelTitle:@"" action:^(NSInteger index) {
        if (index == 0) {
            [weakSelf pickOnePhotoImage];
        }else {
            [weakSelf takePhoto];
        }
    }];
    [sheetView showFromViewController:controller];
}

- (void)publishVideoActionFromController:(UIViewController *)controller {
    WEAKSELF;
    self.keyVC = controller;
    CommonAlertView *sheetView = [CommonAlertView sheetAlertViewWithTitles:@[@"视频选取"] cancelTitle:@"" action:^(NSInteger index) {
        if (index == 0) {
            [weakSelf pickVideo];
        }else {

        }
    }];
    [sheetView showFromViewController:controller];
}

- (void)pickVideo {
    WEAKSELF;
    TZImagePickerController *tzImagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    tzImagePicker.allowTakePicture = NO;
    tzImagePicker.allowTakeVideo = NO;
    tzImagePicker.allowPickingVideo = YES;
    tzImagePicker.allowPickingGif = NO;
    tzImagePicker.allowPickingImage = NO;
    tzImagePicker.showSelectBtn = NO;

    tzImagePicker.statusBarStyle = UIStatusBarStyleLightContent;
    [tzImagePicker setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        if (weakSelf.videoBlock) {
            weakSelf.videoBlock(coverImage, asset);
        }
    }];
    
    tzImagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.keyVC presentViewController:tzImagePicker animated:YES completion:nil];
}


- (void)pickOnePhotoImage {
    WEAKSELF;
    TZImagePickerController *tzImagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    tzImagePicker.allowTakePicture = NO;
    tzImagePicker.allowTakeVideo = NO;
    tzImagePicker.allowPickingVideo = NO;
    tzImagePicker.allowPickingGif = NO;
    tzImagePicker.showSelectBtn = NO;
    tzImagePicker.allowCrop = YES;
    tzImagePicker.needCircleCrop = YES;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.keyVC.view.frameWidth - 2 * left;
    NSInteger top = (self.keyVC.view.frameHeight - widthHeight) / 2;
    tzImagePicker.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    tzImagePicker.scaleAspectFillCrop = YES;
    tzImagePicker.statusBarStyle = UIStatusBarStyleLightContent;
    [tzImagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (weakSelf.imageBlock) {
            weakSelf.imageBlock(photos[0]);
        }
    }];
    
    tzImagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.keyVC presentViewController:tzImagePicker animated:YES completion:nil];
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }]];
        [self.keyVC presentViewController:alertController animated:YES completion:nil];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }]];
        [self.keyVC presentViewController:alertController animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
//    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        _imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.keyVC presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - <TZImagePickerControllerDelegate>

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    WEAKSELF;
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *meta = [info objectForKey:UIImagePickerControllerMediaMetadata];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image meta:meta location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                    if (weakSelf.imageBlock) {
                        weakSelf.imageBlock(cropImage);
                    }
                }];
                imagePicker.allowPickingImage = YES;
                imagePicker.needCircleCrop = YES;
                imagePicker.circleCropRadius = GZ_HorizontalFlexible(150);
                [self.keyVC presentViewController:imagePicker animated:YES completion:nil];
            }
        }];
    }
}


#pragma mark - Getter
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
//        _imagePickerVc.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //改变相册选择页的导航栏外观
        if ([self.keyVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)self.keyVC;
            _imagePickerVc.navigationBar.barTintColor = nav.navigationBar.barTintColor;
            _imagePickerVc.navigationBar.tintColor = nav.navigationBar.tintColor;
        }else {
            _imagePickerVc.navigationBar.barTintColor = self.keyVC.navigationController.navigationBar.barTintColor;
            _imagePickerVc.navigationBar.tintColor = self.keyVC.navigationController.navigationBar.tintColor;
        }
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
 
    }
    return _imagePickerVc;
}

@end
