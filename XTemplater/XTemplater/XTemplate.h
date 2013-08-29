
#import "XTemplater.h"
#import "XAllowedType.h"
#import "XFrameworks.h"

typedef NS_ENUM(NSInteger,XTemplatePlatform)	{ MAC, 	IOS };
typedef NS_ENUM(NSInteger,XTemplateType) 		{ XPROJ,	XFILE };
typedef NS_ENUM(NSInteger,XTemplateCategory)	{ APP,	FWORK_LIB,	APP_PLUGIN,	SYS_PLUGIN,	OTHER,
															  COCOA, COREDATA, 	RESOURCE, 	C,		UI, 	CUSTOM };


@interface XTemplate : NSDocument

- (IBAction) setTypeFrom:		(id)x;
- (IBAction) setCategoryFrom: (id)x;
- (IBAction) setPlatformFrom: (id)x;

@property 							XTemplateType 		type;
@property 							XTemplateCategory category;
@property 							XTemplatePlatform platform;

//Items used by both Project and File Templates

//	Description text for the template. In Project Temp. the Desc. need only be used in TemplateInfo.plist which have the Concrete flag set.
@property (strong,nonatomic) 	NSString *description;
// Describes the type of Xcode template. This is a required key and must not be omitted.
@property (strong,nonatomic) 	NSString *kind;
// List of options for user input. This configures the "Choose options for your new project" page and gives you options to enter the Prod. Name and Company Id.
@property (strong,nonatomic) 	NSMutableArray *options;
// Determines in which platform category (iOS or Mac OS X) the template shows up. If not used, the template will show up for both platforms by default.
@property (strong,nonatomic) 	NSArray *platforms;
//	Used to override the default alphabetical sort order of templates in the New File and New Project dialogs.
@property (strong,nonatomic) 	NSNumber *sortOrder;

//Items Specific to File Templates

//	Specifies the default and all allowed file extension(s) for the file.
@property (strong,nonatomic) 	NSMutableArray *allowedTypes; // USE XAllowedType.identifiers
// The filename (without extension) that Xcode initially suggests.
@property (strong,nonatomic) 	NSString *defaultCompletionName;
// Used only by User Interface XIB templates - is always "TemplateIcon.tiff".
//@property (strong,nonatomic) 	NSString *icon;
// Which of the template files Xcode should open and display after creating the file(s).
@property (strong,nonatomic) 	NSString *mainTemplateFile;
// Does not seem to be used by Xcode, could be (reserved for) a tooltip. Usually identical to the Description except that the sentence doesn't end with a punctuation character. In a few cases it's an abbreviated Description.
@property (strong,nonatomic) 	NSString *summary;
// Used only by User Interface XIB templates - does not seem to be utilized.
@property (strong,nonatomic) 	NSString *title;


//Items Specific to Project Templates
// A list of items with the value part being the Identifier of another TemplateInfo.plist file. Via ancestors you can include other project templates and take over their settings, or override them. Works similar to inheritance in OOP.
@property (strong,nonatomic) 	NSMutableArray *ancestors; //rewuires @"com.apple.dt.unit.objectiveCApplication"
//	Marks the Project Template as the one to be listed in the New Project dialog. If not set, the TemplateInfo.plist will be assumed to be included as ancestor by another TemplateInfo.plist and it will not be shown in the New Project dialog.
@property (strong,nonatomic) 	NSNumber *concrete;  // BOOL
/**
// Defines the content of the Nodes entry with the same name (eg if a Definitions key equals a Nodes value). Normally it is used to indicate where a file is (Path) but can also specify the actual text content of the file.
@[@"Definitions",],
// Only used by the Quartz Composer Plug-In template. Specifies the path to the Quartz Composer.app which indicates that you can somehow specify the dependency to an external app. The effect of this setting is unclear. For reference:
￼	@[@"Executables",],
// Unique Identifier for this template, using reverse domain notation (com.yourcompany.thistemplatefilename).
@[@"Identifier", ],
// The name of the project template as shown in the New Project dialog. If omitted the project template will assume the name of the .xctemplate folder.
@[@"Name", ],
// Lists all the files in the project. Can also contain names of placeholders or functions to add to a file.
@[@"Nodes", ],
// Only used by the Quartz Composer Plug-In template, where it is unchecked. Effect unclear.
@[@"NSSupportsSuddenTermination",],
// Configure Project-Wide Build Configuration settings.
@[@"Project", ],
//Indicates that this template should only be listed in the New Project dialog, but not when adding a new target. Used only by the "Empty" project template.
@[@"ProjectOnly", ],
//	Indicates that this template should only be listed in the Add Target dialog, but not when creating a New Project. Used for example by the "Aggregate" target template.
@[@"TargetOnly", ],
// Allows you to add targets to the project and configure Target-specific settings.
@[@"Targets", ],

*/
@property (strong,nonatomic)  NSImage 		*icon;
@property (strong,nonatomic) 	NSString 	*name;//, *summary;//, *description;
@property (strong,nonatomic) 	NSURL 		*iconPath;
@property (weak) IBOutlet	NSTextField 	*customCategory;
@property (weak) IBOutlet	NSImageView 	*platformImage;

@property (strong,nonatomic) 	XTemplater 		*templater;
@property (strong,nonatomic)  NSMutableArray *frameworks;
@end


//+ (instancetype) templateNamed:(NSString*)name
//							 iconPath:(NSString*)iconPath
//							 platform:(XTemplatePlatform)platform
//							 category:(XTemplateCategory)cat;
