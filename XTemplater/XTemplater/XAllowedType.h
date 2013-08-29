


typedef NS_ENUM(NSUInteger, XAllowedTypes) {
	OBJECTIVE_C_SOURCE,
	OBJECTIVE_C_PLUS_PLUS_SOURCE,
	C_SOURCE,
	C_PLUS_PLUS_SOURCE,
	C_HEADER,
	RUBY_SCRIPT,
	PYTHON_SCRIPT,
	JAVA_CLASS,
	JAVA_SOURCE,
	XML,
	SOURCE_CODE
};

@interface XAllowedType : NSObject
+ (instancetype) instanceOfType:(XAllowedTypes) type;
@property				XAllowedTypes 	type;
@property (readonly) NSString 		*idetifier,
												*displayName;
@end
