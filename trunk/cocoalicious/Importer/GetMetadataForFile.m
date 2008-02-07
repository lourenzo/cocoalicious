#import <CoreFoundation/CoreFoundation.h>
#import <CoreServices/CoreServices.h> 
#import <Foundation/Foundation.h>

/* -----------------------------------------------------------------------------
   Step 1
   Set the UTI types the importer supports
  
   Modify the CFBundleDocumentTypes entry in Info.plist to contain
   an array of Uniform Type Identifiers (UTI) for the LSItemContentTypes 
   that your importer can handle
  
   ----------------------------------------------------------------------------- */

/* -----------------------------------------------------------------------------
   Step 2 
   Implement the GetMetadataForFile function
  
   Implement the GetMetadataForFile function below to scrape the relevant
   metadata from your document and return it as a CFDictionary using standard keys
   (defined in MDItem.h) whenever possible.
   ----------------------------------------------------------------------------- */

/* -----------------------------------------------------------------------------
   Step 3 (optional) 
   If you have defined new attributes, update the schema.xml file
  
   Edit the schema.xml file to include the metadata keys that your importer returns.
   Add them to the <allattrs> and <displayattrs> elements.
  
   Add any custom types that your importer requires to the <attributes> element
  
   <attribute name="com_mycompany_metadatakey" type="CFString" multivalued="true"/>
  
   ----------------------------------------------------------------------------- */



/* -----------------------------------------------------------------------------
    Get metadata attributes from file
   
   This function's job is to extract useful information your file format supports
   and return it as a dictionary
   ----------------------------------------------------------------------------- */

Boolean GetMetadataForFile(void* thisInterface, 
			   CFMutableDictionaryRef attributes, 
			   CFStringRef contentTypeUTI,
			   CFStringRef pathToFile)
{
    /* Pull any available metadata from the file at the specified path */
    /* Return the attribute keys and attribute values in the dict */
    /* Return TRUE if successful, FALSE if there was no data provided */
    
	Boolean success = NO;
	NSDictionary *masterDict;
	NSAutoreleasePool *pool;
	
	pool = [[NSAutoreleasePool alloc] init];
	
	masterDict = [[NSDictionary alloc] initWithContentsOfFile:(NSString *)pathToFile];
	
	if (masterDict) {
		NSArray * keys = [masterDict allKeys];
		NSString * url = nil;
		
		if([keys count] > 0) {
			[(NSMutableDictionary *)attributes setObject:@"Cocoalicious Post" forKey:(NSString *)kMDItemKind];

			// each stub file should only contain one URL / post
			url = [keys objectAtIndex:0];
			[(NSMutableDictionary *)attributes setObject:url forKey:@"kMDItemURL"];
			
			NSDictionary * postDict = [masterDict objectForKey:url];

			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"description"] forKey:(NSString *)kMDItemDisplayName];
			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"description"] forKey:(NSString *)kMDItemTitle];
			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"description"] forKey:(NSString *)kMDItemHeadline];

			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"extended"] forKey:(NSString *)kMDItemDescription];

			[(NSMutableDictionary *)attributes setObject:[NSCalendarDate dateWithString:[postDict objectForKey:@"post-date"] calendarFormat:@"%Y-%m-%dT%H:%M:%SZ%Z"] forKey:(NSString *)kMDItemContentCreationDate];

			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"tags"] forKey:(NSString *)kMDItemKeywords];
			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"tags"] forKey:@"com_scifihifi_cocoalicious_Tags"];
			
			[(NSMutableDictionary *)attributes setObject:[postDict objectForKey:@"private"] forKey:@"com_scifihifi_cocoalicious_Private"];

			success = YES;
		}
		
		[masterDict release];
	}
	
	[pool release];
	
	return success;
}
