//
//  SettingsViewController.m
//  tipcalc
//
//  Created by Tushar Bhushan on 6/5/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *defaultTipSegment;
- (IBAction)onTap:(id)sender;

@end

@implementation SettingsViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"key"];
    if (intValue == 0 || intValue == 1 || intValue == 2){
        
        self.defaultTipSegment.selectedSegmentIndex = intValue;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
    [self setDefaults];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setDefaults {
    NSLog(@"Calling set function");
    int selectedSegment = self.defaultTipSegment.selectedSegmentIndex;
    NSLog(@"int value %d", selectedSegment);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedSegment forKey:@"key"];
    [defaults synchronize];
}
@end
