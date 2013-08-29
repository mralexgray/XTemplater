//
//  XAllowedType.m
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import "XAllowedType.h"

@implementation XAllowedType

+ (instancetype) instanceOfType:(XAllowedTypes) type {
	XAllowedType *t = self.new;
	t.type = type;
	return t;
}

- (NSString*)idetifier {

	return	_type == OBJECTIVE_C_SOURCE ? @"public.objective-c-source" : // (Objective-C)
				_type == OBJECTIVE_C_PLUS_PLUS_SOURCE ? @"public.objective-c-plus-plus-source" : // (Objective C++)
				_type == C_SOURCE ? @"public.c-source" : // (C)
				_type == C_PLUS_PLUS_SOURCE ? @"public.c-plus-plus.source" : //(C++)
				_type == C_HEADER ? @"public.c-header" : // (header file for C, C++, Objective C)
				_type == RUBY_SCRIPT ? @"public.ruby-script" : // (Ruby)
				_type == PYTHON_SCRIPT ? @"public.python-script" : // (Python)
				_type == JAVA_CLASS ? @"com.sun.java-class" : // (Java .class file)
				_type == JAVA_SOURCE ? @"com.sun.java-source" : // (Java .java file)
				_type == XML ? @"public.xml" : // (XML)
				_type == SOURCE_CODE ? @"public.source-code" : nil; // (generic source code)
}
- (NSString*)displayName {

	return	_type == OBJECTIVE_C_SOURCE ? @"Objective-C" :
				_type == OBJECTIVE_C_PLUS_PLUS_SOURCE ? @"Objective C++" :
				_type == C_SOURCE ? @"C" :
				_type == C_PLUS_PLUS_SOURCE ? @"C++" :
				_type == C_HEADER ? @"header file for C, C++, Objective C" :
				_type == RUBY_SCRIPT ? @"Ruby" :
				_type == PYTHON_SCRIPT ? @"Python" :
				_type == JAVA_CLASS ? @"Java .class file" :
				_type == JAVA_SOURCE ? @"Java .java file" :
				_type == XML ? @"XML" :
				_type == SOURCE_CODE ? @"generic source code" : nil;
}
@end
