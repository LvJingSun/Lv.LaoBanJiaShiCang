//
//  BusinessLogoViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 13-11-21.
//  Copyright (c) 2013年 冯海强. All rights reserved.
//

#import "BusinessLogoViewController.h"

#import "CommonUtil.h"
#import "HttpClientRequest.h"
#import "SVProgressHUD.h"
#import "BasicData.h"
#import "SaveData.h"

@interface BusinessLogoViewController ()

@property(nonatomic,weak)IBOutlet UIButton*Business_LogophotoBtn;



@end


@implementation BusinessLogoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       // [self getDataFromServer];
        self.Logodic=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏状态栏
   // [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"Businesser_Logo"];
    if(imageData != nil)
    {
    [self.Business_LogophotoBtn setImage: [NSKeyedUnarchiver unarchiveObjectWithData: imageData] forState:UIControlStateNormal];
    }
    
    self.title=@"Logo";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//logo
-(IBAction)BusinessLogoChangeBtn:(id)sender
{
    
    UIActionSheet *sheet;
    
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    
    sheet.tag = 1;
    [sheet showInView:self.view];
    
    
    
}


-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        //打开照相
        if (buttonIndex==0)
        {
            pickerorphoto=1;
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                //imagePicker.allowsImageEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                
                [self presentViewController:imagePicker animated:YES completion:^{}];
            }
            else{
                //如果没有提示用户
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"手机没有摄像头" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
                [alert show];
            }
        }
        
        //打开相册
        if (buttonIndex == 1) {
            pickerorphoto=0;
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//打开照片文件
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            [self presentViewController:imagePicker animated:YES completion:^{

            }];

        }
        
    }
}



#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image=[[UIImage alloc]init];
    if (pickerorphoto==0)
    {
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }else if (pickerorphoto==1)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    UIImage *scaleImage = [self scaleImage:savedImage toScale:0.3];
    [self.Business_LogophotoBtn setImage:scaleImage forState:UIControlStateNormal];
    
}


- (NSData *)getImageData:(UIImageView *)imageView {
    UIImage *iamge = imageView.image;
    return UIImageJPEGRepresentation(iamge, 1);
}

-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 将图片存储在字典里
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 315,500)];
    
    imgV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(315,500)];

    [self.Logodic setValue:[self getImageData:imgV] forKey:@"logo"];
    
    
    // 计算图片显示的大小
    float height = image.size.width / 302.0f;
    UIGraphicsBeginImageContext(CGSizeMake(302,image.size.height / height));
    [image drawInRect:CGRectMake(0, 0, 302, image.size.height / height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return scaledImage;
    
}





-(IBAction)BusinessLogoSaveBtn:(id)sender
{
     [self PutToserverLogo];

}



-(void)PutToserverLogo
{
    if (self.Logodic.count==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请上传Logo"];
        return;
    }

    MainViewController*mainVC=[MainViewController shareobject];
    // 判断网络是否存在
    if ( ![mainVC isConnectionAvailable] )
    {
        return;
    }
    
    NSUserDefaults*userDefau=[NSUserDefaults standardUserDefaults];
    NSString*memberId=[userDefau objectForKey:@"memberId"];
    HttpClientRequest *httpClient = [HttpClientRequest sharedInstance];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId, @"memberId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据提交中..."];
    
    [httpClient multipartFormRequest:@"MctUpdateLogo.ashx" parameter:param file:self.Logodic successed:^(JSONDecoder *jsonDecoder, id responseObject) {
        
        NSData* data = [NSData dataWithData:responseObject];
        
        NSDictionary* handlJson = [jsonDecoder objectWithData:data];
        
        SaveData *keyData = [[SaveData alloc]initWithJsonObject:handlJson];
        
        BOOL success = [keyData.status boolValue];
        
        if (success)
        {
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:keyData.msg];
            
            UIImage *image=[UIImage imageWithData:[self.Logodic objectForKey:@"logo"]];
            
            NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:[CommonUtil scaleImage:image toSize:CGSizeMake(302,273)]];

            [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"Businesser_Logo"];
            
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(goLastView) userInfo:nil repeats:NO];
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:keyData.msg];
        }
        
    } failured:^(NSError *error) {
        
//        NSLog(@"error:%@",error.description);
        [SVProgressHUD showErrorWithStatus:error.description];
        
    }];


    
}


-(void)goLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}






@end
