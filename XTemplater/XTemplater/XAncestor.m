//
//  XAncestor.m
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import "XAncestor.h"

@implementation XAncestor

+ (instancetype) instanceOfType:(XAncestorType) type {
	XAncestor *a = self.new;
	a.type = type;
	return a;
}

- (NSString*)idetifier {

	return	_type == OBJECTIVECAPPLICATION ? @"com.apple.dt.unit.objectiveCApplication" : // (Objective-C)
				_type == MACBASE ?	@"com.apple.dt.unit.macBase" : nil;
}

@end
