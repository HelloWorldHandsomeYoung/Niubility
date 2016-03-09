//
//  LeftTagController.m
//  NiubilityApp
//
//  Created by 吕阳 on 16/3/8.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import "LeftTagController.h"

@interface LeftTagController ()<UITextViewDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoImg;
/* 照片路径 */
@property (nonatomic, copy)NSString * filePath;
@end

@implementation LeftTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加手势
    [self addRecognizer];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 添加手势
- (void)addRecognizer
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    [self.view addGestureRecognizer:swipe];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.photoImg.userInteractionEnabled = YES;
    [self.photoImg addGestureRecognizer:tap];
}
#pragma mark 划擦手势
- (void)swipeAction:(UISwipeGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 轻拍手势
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self alertViewControllerWillAppear];
}
#pragma mark - 弹出选择
- (void)alertViewControllerWillAppear
{
    UIAlertController * myActionSheet = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self fromLibrary];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [myActionSheet addAction:cancel];
    [myActionSheet addAction:camera];
    [myActionSheet addAction:library];
    
    [self presentViewController:myActionSheet animated:YES completion:nil];
}
- (void)takePhoto
{
    UIImagePickerControllerSourceType source = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = source;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"camera none");
    }
}
- (void)fromLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        self.filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        
        self.photoImg.image = image;
    }
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
