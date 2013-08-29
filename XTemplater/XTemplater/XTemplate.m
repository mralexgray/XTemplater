//
//  XTemplate.m
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import "XTemplate.h"

@implementation XTemplate

+ (instancetype) templateNamed:(NSString*)name
							 iconPath:(NSURL*)iconPath
							 platform:(XTemplatePlatform)platform
							 category:(XTemplateCategory)category {

	XTemplate *t = self.new;
	t.name = name; t.iconPath = iconPath; t.platform = platform; t.category = category;
	return t;
}

- (id)init {

	if (!(self = [super init])) return  nil;
	_templater = [XTemplater forTemplate:self];
	self.type = XPROJ, self.platform = MAC, self.category = -1;
	return self;
}
- (NSMutableArray*) frameworks {

	return _frameworks = _frameworks ?: ^{ _frameworks = NSMutableArray.new;
		for (NSBundle *fw in NSBundle.allFrameworks) {
			XFramework *framework 	= XFramework.new;
			framework.enabled 		= NO;
			framework.name 			= [[fw infoDictionary]objectForKey:@"CFBundleName"] ?: [[[fw bundleIdentifier] lastPathComponent]pathExtension];
			[_frameworks addObject:framework];
		}
		return _frameworks;
	}();
}
- (void)setIconPath:(NSURL*)iconPath { _iconPath = iconPath;

	self.icon 	= 	[NSImage.alloc initWithContentsOfURL:_iconPath]
					?: [NSImage imageNamed:NSImageNameAdvanced];
}
- (void)setCategoryFrom:(id)x {

	[self setCategory:[[x selectedItem] tag]];
	_customCategory.hidden = _category != CUSTOM;
}
- (void)setPlatformFrom:(id)x	{

    self.platform = [x selectedSegment];
	 _platformImage.image = [NSImage imageNamed:_platform == IOS ? @"iPhone" : @"Mac"];
	 self.platforms = @[_platform == IOS ? PLATFORM_IOS.copy : PLATFORM_MAC.copy];
	 NSLog(@"path: %@", _templater.subDir);
}
- (void)setTypeFrom:		(id)x { self.type = [x selectedSegment];
	NSLog(@"segment: %ld, type: %ld",[x selectedSegment], _type);
}

- (NSString*)windowNibName	{
	// Override returning the nib file name of the document
	// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
	return @"XTemplate";
}
+ (BOOL)autosavesInPlace	{ return YES; }

-    (void) windowControllerDidLoadNib:(NSWindowController*)aController	{
	[super windowControllerDidLoadNib:aController];
	// Add any code here that needs to be executed once the windowController has loaded the document's window.
}
- (NSData*) dataOfType:		(NSString*)typeName error:(NSError**)outError	{
	// Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
	// You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	@throw exception;
	return nil;
}
-    (BOOL) readFromData:	(NSData*)data      ofType:(NSString*)typeName error:(NSError**)outError	{
	// Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
	// You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
	// If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
	NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
	@throw exception;
	return YES;
}

@end
