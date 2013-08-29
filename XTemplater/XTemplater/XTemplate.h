//
//  XTemplate.h
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, XTemplatePlatform) { MAC, IOS };
typedef NS_ENUM(NSUInteger, XTemplateCategory) { APP, FWORK_LIB, APP_PLUGIN, SYS_PLUGIN, OTHER, CUSTOM };

@interface XTemplate : NSDocument

- (IBAction) setCategoryFrom:(id)x;
- (IBAction) setPlatformFrom:(id)x;
+ (instancetype) templateNamed:(NSString*)name
							 iconPath:(NSString*)iconPath
							 platform:(XTemplatePlatform)platform
							 category:(XTemplateCategory)cat;

@property 							XTemplateCategory category;
@property 							XTemplatePlatform platform;
@property (strong,nonatomic)  NSImage 		*icon;
@property (strong,nonatomic) 	NSString 	*name;
@property (strong,nonatomic) 	NSURL 		*iconPath;
@property (weak) IBOutlet	NSTextField 	*customCategory;
@property (weak) IBOutlet	NSImageView 	*platformImage;

@end
