//
//  XAncestor.h
//  XTemplater
//
//  Created by Alex Gray on 8/28/13.
//  Copyright (c) 2013 Alex Gray. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XAncestorType) { OBJECTIVECAPPLICATION, MACBASE };

@interface XAncestor : NSObject
+ (instancetype) instanceOfType:(XAncestorType) type;
@property				XAncestorType 	type;
@property (readonly) NSString 			*idetifier,
													*displayName;
@end
