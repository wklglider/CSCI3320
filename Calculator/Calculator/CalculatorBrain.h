//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Wang, Kuilin on 1/29/15.
//  Copyright (c) 2015 Wang, Kuilin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
