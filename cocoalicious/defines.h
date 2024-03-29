#define kDEFAULT_DATE_FORMAT (@"%Y-%m-%d")
#define kDEFAULT_DATE_TIME_FORMAT (@"%Y-%m-%dT%H:%M:%SZ%Z")
#define kLAST_UPDATE_DATE_TIME_FORMAT (@"%Y-%m-%dT%H:%M:%S")
#define kPOSTING_DATE_TIME_FORMAT (@"%Y-%m-%dT%H:%M:%SZ")
#define kDEFAULT_TIME_ZONE_NAME (@"UTC")

#define kDEFAULT_API_URL (@"https://api.del.icio.us/v1")
#define kREGISTRATION_URL @"https://secure.del.icio.us/register"
#define kBLANK_URL @"about:blank"

#define kDEFAULT_SECURITY_DOMAIN (@"del.icio.us API")

#define kUSER_AGENT (@"Cocoal.icio.us/1.0 (v44) (Mac OS X; http://www.scifihifi.com/cocoalicious)")

#define kTAG_SEPARATOR (@" ")
#define kHTTP_PROTOCOL_PREFIX (@"http://")

#define kUSERNAME_DEFAULTS_KEY @"username"
#define kPASSWORD_DEFAULTS_KEY @"password"
#define kAPI_URL_DEFAULTS_KEY @"apiurl"
#define kAUTOLOGIN_DEFAULTS_KEY @"autologin"
#define kOPEN_URLS_IN_BACKGROUND_DEFAULTS_KEY @"openURLsInBackground"
#define kDEACTIVATE_ALPHA_DEFAULTS_KEY @"deactiveAlphaValue"
#define kSHOW_WEB_PREVIEW_DEFAULTS_KEY @"showWebPreview"
#define kSEARCH_TYPE_DEFAULTS_KEY @"searchType"
#define kAUTOMATICALLY_COMPLETE_TAGS_DEFAULTS_KEY @"automaticallyCompleteTags"
#define kTAG_AUTOCOMPLETION_DELAY_DEFAULTS_KEY @"tagAutocompletionDelay"
#define kPOST_LIST_SORT_DEFAULTS_KEY @"postListSortKey"

#define kDATE_SORT_DESCRIPTOR @"date"

#define kDEFAULT_TAG_AUTOCOMPLETION_DELAY 2.0

#define kDESCRIPTION_COLUMN @"description"
#define kEXTENDED_COLUMN @"extended"
#define kURL_COLUMN @"url"

#define kDCAPIPostPboardType @"DCAPIPostPboardType"
#define kDCAPITagRenameFromKey @"from"
#define kDCAPITagRenameToKey @"to"

#define kDCSafariScriptLibrary @"safari_script"
#define kDCScriptType @"scpt"
#define kDCSafariGetCurrentURL @"fetch_safari_url"
#define kDCSafariGetCurrentSelection @"fetch_safari_selection"
#define kScriptError @"ERROR"

#define kREFRESH_BUTTON_IMAGE @"refresh_icon"
#define kADD_POST_BUTTON_IMAGE @"add_post_icon"
#define kDELETE_POST_BUTTON_IMAGE @"delete_post_icon"
#define kSHOW_INFO_BUTTON_IMAGE @"show_info_icon"
#define kTOGGLE_WEB_PREVIEW_BUTTON_IMAGE @"toggle_web_preview_icon"

#define kADD_POST_SEGMENT_TAG 0
#define kDELETE_POST_SEGMENT_TAG 1

#define kPOST_DICTIONARY_KEY_NAME @"URLString"

#define AWOOSTER_CHANGES 1
#define AWOOSTER_DEBUG 0
#define kTEXT_INDEX_PATH @"~/Library/Caches/Cocoalicious"
#define kTEXT_INDEX_NAME @"FullText v1.index"
#define kTEXT_INDEX_VERSION @"HTML Text v1.0"
#define kTEXT_SEARCH_MAX_RESULTS 100000
#define kTEXT_SEARCH_CHUNK_SIZE 30

#define kRATING_IMAGE_NAME @"star.tif"
#define kRATING_HIGHLIGHTED_IMAGE_NAME @"star_highlighted.tif"
#define kMAXIMUM_STAR_RATING 5
#define kRATING_COLUMN_IDENTIFIER @"rating"
#define kRATING_TAG_CHARACTER @"*"
#define kTAGLIST_TAG_COLUMN_IDENTIFIER @"tags"

#define kSAFARI_HISTORY_PATH @"~/Library/Safari/History.plist"

#define kWebURLPboardType				@"CorePasteboardFlavorType 0x75726C20"
#define kWebURLNamePboardType			@"CorePasteboardFlavorType 0x75726C6E"
#define kWebURLsWithTitlesPboardType	@"WebURLsWithTitlesPboardType"

#define FAVICON_SUPPORT 1
#define kFAVICON_DISPLAY_SIZE NSMakeSize(13.0, 13.0)
#define kDEFAULT_FAVICON_NAME @"default_favicon.tif"

#define kLAST_REFRESH_FILE_NAME @"last_refresh_time"
#define kPOST_CACHE_FILE_NAME @"posts"

#pragma mark Spotlight Information
#define kSPOTLIGHT_CACHE_PATH @"Metadata/com.scifihifi.Cocoalicious/"
#define kSPOTLIGHT_CACHE_MAP @"spotlight_cache_map.plist"
#define kSPOTLIGHT_STUB_EXTENSION @".cocoaliciouspost"

#ifndef NSAppKitVersionNumber10_4
#define NSAppKitVersionNumber10_4 824
#endif