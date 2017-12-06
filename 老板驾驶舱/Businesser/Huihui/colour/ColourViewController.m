//
//  ColourViewController.m
//  BusinessCenter
//
//  Created by 冯海强 on 14-2-13.
//  Copyright (c) 2014年 冯海强. All rights reserved.
//

#import "ColourViewController.h"
#import "UIColor-Expanded.h"


@interface ColourViewController ()

@end

@implementation ColourViewController
@synthesize delegate;
@synthesize selectedColor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    
	UIView *container = [[UIView alloc] initWithFrame: IS_IPAD ? CGRectMake(0, 0, 320, 460) :[[UIScreen mainScreen] applicationFrame]];
	container.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	container.backgroundColor = [UIColor clearColor];
	self.view = container;
	
	KZColorPicker *picker = [[KZColorPicker alloc] initWithFrame:container.bounds];
    picker.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	picker.selectedColor = self.selectedColor;
    picker.oldColor = self.selectedColor;
	[picker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:picker];

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title=@"色彩";
    
    UIBarButtonItem *wangcheng =[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(Save)];
    self.navigationItem.rightBarButtonItem =wangcheng;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Save
{
    
    
    
    
    
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

- (void) pickerChanged:(KZColorPicker *)cp
{
    self.selectedColor = cp.selectedColor;

	[delegate defaultColorController:self didChangeColor:cp.selectedColor];
    
//    [self changeUIColorToRGB:cp.selectedColor];
    
}





#pragma mark -
#pragma mark  Popover support
- (CGSize) contentSizeForViewInPopover
{
	return CGSizeMake(320, 416);
}


@end
