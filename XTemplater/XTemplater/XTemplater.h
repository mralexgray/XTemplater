

#define DEFAULT_TEMPLATE_DIR 	@"~/Library/Developer/Xcode/Templates"
#define FILE_FOLDER 				@"File Templates"
#define KIND_FILE 				@"Xcode.IDEKit.TextSubstitutionFileTemplateKind"

#define PROJ_FOLDER 				@"Project Templates"
#define KIND_PROJECT 			@"Xcode.Xcode3.ProjectTemplateUnitKind"

#define INFO_PLIST 				@"TemplateInfo.plist"

#define PLATFORM_MAC 			@"com.apple.platform.macosx"
#define PLATFORM_IOS 			@"com.apple.platform.iphoneos"

#define PKGNAMEID					___PACKAGENAMEASIDENTIFIER___

@class XTemplate;
@interface XTemplater : NSObject

+ (instancetype) forTemplate:(XTemplate*)template;

@property (weak) 					XTemplate 		*template;
@property (nonatomic, strong) NSString 		*templateDir, *subDir, *path;
@property (nonatomic, strong) NSDictionary 	*infoDict;
@property (nonatomic, strong) NSAttributedString 	*plistString;

@property (copy) NSArray *mutualKeys, *fileKeys, *projectKeys;
@end
