//
//  ViewController.m
//  Calculator
//
//  Created by Wang, Kuilin on 1/29/15.
//  Copyright (c) 2015 Wang, Kuilin. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize uperDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}
//Send every number and "." to digit.
- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if (![self.display.text containsString:@"."] || ![digit isEqualToString:@"."]) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
        if ([digit isEqualToString:@"."]) {
            self.display.text = @"0.";
        } else {
            self.display.text = digit;
        }
        if (![self.display.text isEqualToString:@"0"]) {
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
}
//Positive and negetive
- (IBAction)flipPressed {
    if ([[self.display.text substringToIndex:1] isEqualToString:@"-"]) {
        self.display.text = [self.display.text substringFromIndex:1];
    } else if (![self.display.text isEqualToString:@"0"]) {
        self.display.text = [@"-" stringByAppendingString:self.display.text];
    }
}
//Backspace implementation
- (IBAction)backspacePressed {
    if ([self.display.text length] == 1 || (([self.display.text length] == 2) && ([[self.display.text substringToIndex:1] isEqualToString:@"-"]))) {
        self.display.text = @"0";
        self.userIsInTheMiddleOfEnteringANumber = NO;
    } else {
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
    }
}
//Push self.deisplay.text into operandStack
- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:self.display.text];
    self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@" "];
    self.uperDisplay.text = [self.uperDisplay.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}
//Operation
- (IBAction)operationPressed:(id)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    if ([operation isEqualToString:@"C"]) {
        self.uperDisplay.text = @"";
        self.userIsInTheMiddleOfEnteringANumber = NO;
//reset self.display.text to 0 and self.userIsInTheMiddleOfEnteringANumber to NO
    } else if ([operation isEqualToString:@"x"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"x "];
    } else if ([operation isEqualToString:@"/"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"/ "];
    } else if ([operation isEqualToString:@"+"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"+ "];
    } else if ([operation isEqualToString:@"-"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"- "];
    } else if ([operation isEqualToString:@"sin"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"sin "];
    } else if ([operation isEqualToString:@"cos"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"cos "];
    } else if ([operation isEqualToString:@"sqrt"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"sqrt "];
    }
    if (![operation isEqualToString:@"C"]) {
        self.uperDisplay.text = [self.uperDisplay.text stringByReplacingOccurrencesOfString:@"=" withString:@""];
        self.uperDisplay.text = [self.uperDisplay.text stringByAppendingString:@"="];
    }
    //add = in the last of the string
}

@end
