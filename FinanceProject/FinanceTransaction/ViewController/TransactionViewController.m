//
//  TransactionViewController.m
//  FinanceProject
//
//  Created by Вадим Чистяков on 17.06.17.
//  Copyright © 2017 Вадим Чистяков. All rights reserved.
//

#import "TransactionViewController.h"
#import "TransactionDB+CoreDataClass.h"
#import "AppDelegate.h"
#import "TableSpendingViewController.h"

@interface TransactionViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *summField;
@property (weak, nonatomic) IBOutlet UITextField *noteField;
@property (weak, nonatomic) IBOutlet UIPickerView *category;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) NSArray *pickerDataSource;

@property(copy, nonatomic) NSString *name;
@property(assign, nonatomic) double summ;
@property(copy, nonatomic) NSString *note;
@property(copy, nonatomic) NSString *selectedCategory;

- (IBAction)saveButton:(UIBarButtonItem *)sender;

@end

@implementation TransactionViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setpickerDataSource];
    self.nameField.delegate = self;
    self.summField.delegate = self;
}

#pragma mark - Configure


#pragma mark - Configure DatePicker

- (void)setpickerDataSource {
    
    self.pickerDataSource = [NSArray arrayWithObjects:
                   @"Food",
                   @"Сommunal",
                   @"Taxation",
                   @"Entertainment",
                   @"Credit",
                   @"Another",
                   @"-------",
                   @"Salary",
                   @"Dotation",
                   @"Stipyha",
                    nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.category = nil;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerDataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return [self.pickerDataSource objectAtIndex:row];
}

#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
    self.selectedCategory = self.pickerDataSource[row];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.nameField]) {
        [textField resignFirstResponder];
        self.name = textField.text;
       [self.summField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
        self.summ = [textField.text doubleValue];
        
    }
    return YES;
}


- (IBAction)saveButton:(UIBarButtonItem *)sender {
    if (!self.name) {
        self.nameField.text = @" ";
    } else {
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext * context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription *transactionDescription = [NSEntityDescription  entityForName:@"TransactionDB" inManagedObjectContext:context];
    
    TransactionDB * transaction = [[TransactionDB alloc] initWithEntity:transactionDescription insertIntoManagedObjectContext:context];
    
    transaction.name = self.name;
    transaction.summ = [NSString stringWithFormat:@"%02.f", self.summ];
    transaction.note = self.note;
    transaction.datePicker = self.datePicker.date;
    transaction.category = self.selectedCategory;
    transaction.isSpending = self.segmentControl.selectedSegmentIndex;
    
    if (self.selectedCategory) {
        transaction.category = self.selectedCategory;
    } else {
        transaction.category = self.pickerDataSource[0];
    }
    
    NSLog(@"%d",transaction.isSpending);
    
    NSString *words = [[NSString alloc]initWithFormat:@"Дата: %@", self.datePicker.date];
    NSLog(@"%@",transaction.category);
    NSLog(@"%@",words);
    [appDelegate saveContext];
    [self showAlert];
    }

}

- (void)showAlert {
    UIAlertController * alert = [UIAlertController
                alertControllerWithTitle:@"Saved!"
                                 message:@"Transaction successfully saved"
                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];

    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)didPinch:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
