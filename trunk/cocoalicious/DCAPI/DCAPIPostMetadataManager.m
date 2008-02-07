//
//  DCAPIPostMetadata.m
//  Delicious Client
//
//  Created by Eric Blair on 8/31/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "DCAPIPostMetadataManager.h"

@implementation DCAPIPostMetadataManager

+ (DCAPIPostMetadataManager *) DCAPIPostMetadataManagerForUsername: (NSString *) username {
	DCAPIPostMetadataManager *manager = [[DCAPIPostMetadataManager alloc] initWithUsername: username];
	return [manager autorelease];
}

- initWithUsername: (NSString *) newUsername {
	if (self = [super init]) {
		[self setUsername: newUsername];
		NSString * postMetadataMapPath = [DCAPIPostMetadataManager postMetadataMapPathForUsername: [self username]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:postMetadataMapPath])
			[self setPostMetadataMap: [NSMutableDictionary dictionaryWithContentsOfFile: postMetadataMapPath]];
		else
			postMetadataMap = [[NSMutableDictionary alloc] init];
	
		return self;
	}
	
	return nil;
}

- (void) dealloc {
	[username release];
	[postMetadataMap release];
	
	[super dealloc];
}

- (void) refreshPostMetadata: (NSArray *) posts {
	NSString *postMetadataPath = [DCAPIPostMetadataManager postMetadataPathForUsername: [self username]];
	NSString *postMetadataMapPath = [DCAPIPostMetadataManager postMetadataMapPathForUsername: [self username]];
	
	BOOL postMetadataExists = [[NSFileManager defaultManager] fileExistsAtPath: postMetadataPath];
	BOOL postMetadataMapExists = [[NSFileManager defaultManager] fileExistsAtPath: postMetadataMapPath];
	
	if (!postMetadataExists || !postMetadataMapExists) {
		// If neither the metadata folder nor the map exist, recreate the metadata
		[self addPosts: posts clean: YES];
	}
	else {
		NSMutableArray *postsToAdd = [NSMutableArray array];
		NSEnumerator *postEnumerator = [posts objectEnumerator];
		DCAPIPost *currentPost;
		NSString *currentURLString;
		NSString *stubFilename;
		NSString *stubFilePath;
		
		while ((currentPost = (DCAPIPost *)[postEnumerator nextObject]) != nil) {
			BOOL addPost = NO;
			currentURLString = [[currentPost URL] absoluteString];
			stubFilename = [[self postMetadataMap] objectForKey: currentURLString];
			
			if (stubFilename) {
				stubFilePath = [self metadataStubPathForFilename: stubFilename];
				if (![[NSFileManager defaultManager] fileExistsAtPath: stubFilePath]) {
					addPost = YES;
				}
			}
			else {
				addPost = YES;
			}
			
			if (addPost) {
				[postsToAdd addObject: currentPost];
			}
		}
		
		if ([postsToAdd count] > 0) {
			[self addPosts: postsToAdd clean: NO];
		}
	}
}

- (void) addPosts: (NSArray *) posts clean: (BOOL) clean {
	NSString *postMetadataPath = [DCAPIPostMetadataManager postMetadataPathForUsername: [self username]];
	NSString *postMetadataMapPath = [DCAPIPostMetadataManager postMetadataMapPathForUsername: [self username]];
	NSMutableDictionary *map;
	NSEnumerator *postEnumerator = [posts objectEnumerator];
	DCAPIPost *currentPost;
	
	if (clean) {
		if ([[NSFileManager defaultManager] fileExistsAtPath: postMetadataPath]) {
			[[NSFileManager defaultManager] removeFileAtPath: postMetadataPath handler: nil];
		}
		map = [NSMutableDictionary dictionaryWithCapacity: [posts count]];
	}
	else {
		map = [self postMetadataMap];
	}

	[[NSFileManager defaultManager] createPath: postMetadataPath attributes: nil];
	
	while ((currentPost = (DCAPIPost *)[postEnumerator nextObject]) != nil) {
		NSString *URLString = [[currentPost URL] absoluteString];
		NSDictionary *postDictionary = [currentPost dictionaryRepresentation];
		NSString *stubFilename;
		NSString *stubFilePath;

		stubFilename = [map objectForKey: URLString];
		// If metadata does not exist for the post, create a new entry and filename
		if (!stubFilename) {
			CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
			stubFilename = [NSString stringWithFormat:@"%@%@", (NSString *)CFUUIDCreateString(NULL, uuid), kSPOTLIGHT_STUB_EXTENSION];
			CFRelease(uuid);
		}
		stubFilePath = [self metadataStubPathForFilename: stubFilename];
		
		if ([[NSDictionary dictionaryWithObject:postDictionary forKey:URLString] writeToFile: stubFilePath atomically: YES]) {
			[map setObject: stubFilename forKey: URLString];
		}
		else {
			NSLog(@"Can't write stub metadata for post %@", URLString);
		}
	}
	
	[self setPostMetadataMap: map];
	
	[[NSFileManager defaultManager] createPathToFile: postMetadataMapPath attributes: nil];
	
	if (![map writeToFile: postMetadataMapPath atomically: YES]) {
		NSLog(@"Can't write post metadata map");
	}
}

- (void) removePosts: (NSArray *) posts {
	NSEnumerator *postEnumerator = [posts objectEnumerator];
	DCAPIPost *currentPost;
	NSString *currentURLString;
	NSString *stubFilename;
	NSString *stubFilePath;
	
	while ((currentPost = [postEnumerator nextObject]) != nil) {
		currentURLString = [[currentPost URL] absoluteString];
		stubFilename = [[self postMetadataMap] objectForKey: currentURLString];
		// If an metadata entry exists for the post, delete it
		if (stubFilename) {
			stubFilePath = [self metadataStubPathForFilename: stubFilename];
			if ([[NSFileManager defaultManager] fileExistsAtPath: stubFilePath]) {
				[[NSFileManager defaultManager] removeFileAtPath: stubFilePath handler: nil];
			}
			[[self postMetadataMap] removeObjectForKey: currentURLString];
		}
	}
	
	NSString *postMetadataMapPath = [DCAPIPostMetadataManager postMetadataMapPathForUsername: [self username]];
	[[NSFileManager defaultManager] createPathToFile: postMetadataMapPath attributes: nil];
	
	if (![[self postMetadataMap] writeToFile: postMetadataMapPath atomically: YES]) {
		NSLog(@"Can't write post metadata map");
	}
}

- (NSString *) metadataStubPathForFilename: (NSString *)stubFilename {
	NSString *postMetadataPath = [DCAPIPostMetadataManager postMetadataPathForUsername: [self username]];
	return [postMetadataPath stringByAppendingPathComponent: stubFilename];
}


- (void) setUsername: (NSString *) newUsername {
	if (username != newUsername) {
		[username release];
		username = [newUsername copy];
	}
}

- (NSString *) username {
	return [[username retain] autorelease];
}

- (void) setPostMetadataMap: (NSDictionary *) newPostMetadataMap {
	if (newPostMetadataMap != postMetadataMap) {
		[postMetadataMap release];
		postMetadataMap = [newPostMetadataMap mutableCopy];
	}
}

- (NSMutableDictionary *) postMetadataMap {
	return [[postMetadataMap retain] autorelease];
}

+ (NSString *) postMetadataPathForUsername: (NSString *)username {
	NSArray * domains = 
		NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
											NSUserDomainMask,
											YES);
	NSString * baseDir = [domains objectAtIndex:0];
	NSArray *metadataPathComponents = [NSArray arrayWithObjects: baseDir, kSPOTLIGHT_CACHE_PATH, username, @"", nil];
	NSString *metadataPath = [NSString pathWithComponents:metadataPathComponents];

	return metadataPath;
}

+ (NSString *) postMetadataMapPathForUsername: (NSString *)username {
	NSString *supportDir = [[NSFileManager defaultManager] getApplicationSupportFolder];
	NSArray *metadataMapPathComponents = [NSArray arrayWithObjects: supportDir, username, kSPOTLIGHT_CACHE_MAP, nil];
	NSString *metadataMapPath = [NSString pathWithComponents:metadataMapPathComponents];
	
	return metadataMapPath;
}

@end
