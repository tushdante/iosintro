//
//  tipViewController.m
//  tipcalc
//
//  Created by Tushar Bhushan on 6/4/14.
//  Copyright (c) 2014 Tushar Bhushan. All rights reserved.
//

#import "tipViewController.h"
#import "SettingsViewController.h"

@interface tipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)setValues;
- (void)onSettingsButton;

@end

@implementation tipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    

    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues{
    NSLog(@"Updating Values");

    float billAmount = [self.billTextField.text floatValue];
    if (billAmount < 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Amount"
                                                        message:@"Please enter a non-negative bill amount"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = [tipValues[self.tipControl.selectedSegmentIndex] floatValue] * billAmount;
    float totalAmount = billAmount + tipAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", totalAmount];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"OK"]){
        [self setValues];
    }
}

- (void)setValues{
    float baseAmount = 0;
    self.billTextField.text = self.billTextField.placeholder;
    self.tipLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", baseAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%@%.2f", @"$", baseAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int intValue;
    NSLog(@"New tip amount");
    
    intValue = [defaults integerForKey:@"key"];
    NSLog(@"%d", intValue);
    if (intValue == 0 || intValue == 1 || intValue == 2){
        
        self.tipControl.selectedSegmentIndex = intValue;
    }
}

@end
