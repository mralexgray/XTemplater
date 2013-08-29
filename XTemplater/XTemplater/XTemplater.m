//
//  XTemplateDirectory.m
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import "XTemplater.h"
#import "IconFamily.h"

#define fm NSFileManager.defaultManager

@implementation XTemplater

+ (instancetype) pathWithTemplate:(XTemplate*)template {

	XTemplater *templater = [self.alloc init];
	templater.template = template;
	return templater;
}

- (NSString*)path {

	return _path = _path ?: ^{
	 	_path =  [[DEFAULT_TEMPLATE_DIR stringByExpandingTildeInPath] stringByResolvingSymlinksInPath];
		if (![fm fileExistsAtPath:_path])
			[fm createDirectoryAtPath:_path withIntermediateDirectories:NO attributes:nil error:nil];
		return _path;
	}();
}


- (void) saveIcon {

	IconFamily *fam = [IconFamily.alloc initWithThumbnailsOfImage:_template.icon];
	if (fam)
		[fam writeToFile:[self.path stringByAppendingPathComponent:@"TemplateIcon.icns"]];
	else printf("%s","Problem saving icon!");
}

@end
