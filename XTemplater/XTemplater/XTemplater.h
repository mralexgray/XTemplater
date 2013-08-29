//
//  XTemplateDirectory.h
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTemplate.h"

#define DEFAULT_TEMPLATE_DIR @"~/Library/Developer/Xcode/Templates/File Templates/"

@interface XTemplater : NSObject

+ (instancetype) pathWithTemplate:(XTemplate*)template;

@property (weak) 					XTemplate 	*template;
@property (nonatomic, strong) NSString 	*path;

@end
