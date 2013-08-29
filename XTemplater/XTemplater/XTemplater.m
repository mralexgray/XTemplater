
#import "XTemplater.h"
#import "IconFamily.h"
#import "XTemplate.h"

@implementation XTemplater

+ (instancetype) forTemplate:(XTemplate*)template {

	XTemplater *templater 	= self.new;
	templater.template 		= template;
	return templater;
}
+ (NSSet*) keyPathsForValuesAffectingPath {

	return [NSSet setWithArray:@[@"template.category", @"template.platform", @"template.name", @"template.type"]];
}

+ (NSArray*)mutualKeys { return @[@"Description",@"Kind",@"Options",@"Platforms",@"SortOrder"];	}

+ (NSArray*)fileKeys { return @[@"AllowedTypes", @"DefaultCompletionName", @"Icon", @"MainTemplateFile", @"Summary", @"Title"];	}

+ (NSArray*)projectKeys { return @[@"Ancestors",@"Concrete", @"Definitions", @"Executables", @"Identifier", @"Name", @"Nodes", @"NSSupportsSuddenTermination", @"Project", @"ProjectOnly",  @"TargetOnly", @"Targets"];
}

+ (NSSet*) keyPathsForValuesAffectingPlistString {

	__block NSMutableArray *a = NSMutableArray.new;
	[@[self.mutualKeys, self.projectKeys, self.fileKeys] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		for (NSString*s in obj) {
				NSString *kp = [@"template." stringByAppendingString:s.lowercaseString];
			NSLog(@"%@", kp);
			[a addObject:kp];
		}
	}];
	[a addObject:@"template.type"];
	return [NSSet setWithArray:a];
}

- (NSString*)templateDir {

	return _templateDir = _templateDir ?: DEFAULT_TEMPLATE_DIR.stringByExpandingTildeInPath. stringByResolvingSymlinksInPath;
}
- (NSString*) subDir {

	return _subDir = // _subDir ?: 	(((NSInteger)_template.type) != -1)
		[self.templateDir stringByAppendingPathComponent:
			_template.type == XPROJ ? PROJ_FOLDER : FILE_FOLDER];
//									 : 	nil;
}

//		[self.templateDir stringByAppendingPathComponent: [self stringForCategory:_template.category]];
//			templatesDir = [templatesDir stringByAppendingPathComponent:@"Mac"]

- (NSString*)path {  NSLog(@"%@", @"Calculating path");

	return _path =
//		(((NSInteger)_template.type) != -1 && _template.name && _template.category ) ?
		[[self.subDir stringByAppendingPathComponent:_template.name]stringByAppendingPathExtension:@"xctemplate"];
		// : nil;
}
- (void) createPaths {

	if ( self.templateDir && ![fm fileExistsAtPath:_templateDir])
		[fm createDirectoryAtPath:_templateDir withIntermediateDirectories:NO attributes:nil error:nil];
	if (self.subDir && ![fm fileExistsAtPath:_subDir])
			[fm createDirectoryAtPath:_subDir withIntermediateDirectories:NO attributes:nil error:nil];

}
- (NSString*) stringForCategory:(XTemplateCategory)cat {

	return  	cat == C 			? @"C and C++" :
				cat == COCOA 		? @"Cocoa"	:
				cat == COREDATA 	? @"Core Data" :
				cat == OTHER 		? @"Other" :
				cat == RESOURCE 	? @"Resource" :
				cat == UI 			? @"User Interface" : nil;
}
- (NSAttributedString*)plistString {

	NSLog(@"%@", @"Calculating string");

	NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"temp.plist"];
	[self.infoDict writeToFile:path atomically:YES];
	return _plistString = [NSAttributedString.alloc initWithString:[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
}


- (NSDictionary*)infoDict {


	//The TemplateInfo.plist file has the following keys (this may not be an exhaustive list) for file templates:
	__block NSMutableDictionary *d = NSMutableDictionary.new;
	[self.class.mutualKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		if ([_template respondsToSelector:NSSelectorFromString([obj lowercaseString])]) {
			NSLog(@"template responds to %@", [obj lowercaseString]);
			id val = [_template valueForKey:[obj lowercaseString]];
			if (val) {
				NSString *dKey = [obj capitalizedString];
				d[dKey] = val; NSLog(@"set %@ for %@", val, dKey);
			}
		}
	}];
	if (_template.type == XFILE) {
		[self.class.fileKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			if ([_template respondsToSelector:NSSelectorFromString([obj lowercaseString])]) {
				NSLog(@"template responds to %@", [obj lowercaseString]);
				id val = [_template valueForKey:[obj lowercaseString]];
				if (val) {
					NSString *dKey = [obj capitalizedString];
					d[dKey] = val; NSLog(@"set %@ for %@", val, dKey);
				}
			}
		}];
	}

	if (_template.type == XPROJ) {
		[self.class.projectKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			if ([_template respondsToSelector:NSSelectorFromString([obj lowercaseString])]) {
				NSLog(@"template responds to %@", [obj lowercaseString]);

				id val = [_template valueForKey:[obj lowercaseString]];
				if (val) {
					NSString *dKey = [obj capitalizedString];
					d[dKey] = val; NSLog(@"set %@ for %@", val, dKey);
				}


			}
		}];
	}
//	d[@"AllowedTypes"] = [_template.allowedTypes valueForKey:@"identifier"];
//	d[@"CounterpartTemplateFile"] =
//	d[@"DefaultCompletionName"] = 
//	Description
	d[@"Kind"] = _template.type == XPROJ ? KIND_PROJECT : KIND_FILE;
//	MainTemplateFile
//	MacOSXVersionMin
//	Options
//	Platforms
//SortOrder
//Summary
//	d[@"Targets"] = @[self.targets ?: @""] ?: @"";
	return _infoDict = d;
}

- (NSDictionary*) targets {

/**
	<array>
		<dict>
			<key>ProductType</key>
			<string>com.apple.product-type.bundle</string>
			<key>SharedSettings</key>
			<dict>
				<key>INSTALL_PATH</key>
				<string>$(HOME)/Library/Developer/Xcode/Plug-ins</string>
				<key>WRAPPER_EXTENSION</key>
				<string>ideplugin</string>
				<key>GCC_ENABLE_OBJC_GC</key>
				<string>supported</string>
			</dict>
			<key>BuildPhases</key>
			<array>
				<dict>
					<key>Class</key>
					<string>Sources</string>
				</dict>
				<dict>
					<key>Class</key>
					<string>Frameworks</string>
				</dict>
				<dict>
					<key>Class</key>
					<string>Resources</string>
				</dict>
			</array>
			<key>Frameworks</key>
			<array>
				<string>Cocoa</string>
			</array>
			<key>OtherFrameworks</key>
			<array>
				<string>AppKit</string>
				<string>CoreData</string>
				<string>Foundation</string>
			</array>
		</dict>

*/
}

- (void) saveIcon {

	IconFamily *fam = [IconFamily.alloc initWithThumbnailsOfImage:_template.icon];
	if (fam)
		[fam writeToFile:[self.path stringByAppendingPathComponent:@"TemplateIcon.icns"]];
	else printf("%s","Problem saving icon!");
}

@end
