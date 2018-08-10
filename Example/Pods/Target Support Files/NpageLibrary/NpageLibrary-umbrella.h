#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "NSString+MD5_SHA1.h"
#import "NSString+Sha256.h"

FOUNDATION_EXPORT double NpageLibraryVersionNumber;
FOUNDATION_EXPORT const unsigned char NpageLibraryVersionString[];

