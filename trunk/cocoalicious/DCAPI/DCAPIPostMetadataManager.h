//
//  DCAPIPostMetadata.h
//  Delicious Client
//
//  Created by Eric Blair on 8/31/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DCAPIClient.h"
#import "DCAPIPost.h"
#import "DCTypes.h"
#import "NSFileManager+ESBExtensions.h"
#import "defines.h"

@interface DCAPIPostMetadataManager : NSObject {
	NSMutableDictionary *postMetadataMap;
	NSString *username;
}

+ (DCAPIPostMetadataManager *) DCAPIPostMetadataManagerForUsername: (NSString *)username;
- initWithUsername: (NSString *)newUsername;

- (void) refreshPostMetadata: (NSArray *) posts;
- (void) addPosts: (NSArray *) posts clean: (BOOL) clean;
- (void) removePosts: (NSArray *) posts;

- (NSString *) metadataStubPathForFilename: (NSString *) stubFilename;

- (void) setUsername: (NSString *) newUsername;
- (NSString *) username;
- (void) setPostMetadataMap: (NSDictionary *) newPostMetadataMap;
- (NSMutableDictionary *) postMetadataMap;

+ (NSString *) postMetadataPathForUsername: (NSString *)username;
+ (NSString *) postMetadataMapPathForUsername: (NSString *)username;

@end
