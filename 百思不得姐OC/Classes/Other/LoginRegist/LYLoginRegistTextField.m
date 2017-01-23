//
//  LYLoginRegistTextField.m
//  百思不得姐OC
//
//  Created by linyi on 7/5/16.
//  Copyright © 2016 linyi. All rights reserved.
//

#import "LYLoginRegistTextField.h"

@implementation LYLoginRegistTextField

- (void)awakeFromNib
{
    [self setPlaceholderTextColor:[UIColor grayColor]];
   
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)setPlaceholderTextColor:(UIColor *)color
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = color;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
}

- (void)editingDidBegin
{
    [self setPlaceholderTextColor:[UIColor whiteColor]];
}

- (void)editingDidEnd
{
    [self setPlaceholderTextColor:[UIColor grayColor]];
}

//- (BOOL)becomeFirstResponder
//{
//    [self setPlaceholderTextColor:[UIColor whiteColor]];
//    return [super becomeFirstResponder];
//}
//
//- (BOOL)resignFirstResponder
//{
//    [self setPlaceholderTextColor:[UIColor grayColor]];
//    return [super resignFirstResponder];
//}

@end
