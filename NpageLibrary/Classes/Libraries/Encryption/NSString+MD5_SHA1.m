//
//  NSString+MD5_SHA1.m
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

#import "NSString+MD5_SHA1.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5_SHA1)

- (NSString *) sha1HexDigest
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* outputString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [outputString appendFormat:@"%02x", digest[i]];
    
//    NSLog(@"sha1HexDigest : %@", outputString);
    return outputString;
}

- (NSString *) md5HexDigest
{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [outputString appendFormat:@"%02x", digest[i]];
    
    NSLog(@"MD5 : %@", outputString);
    return  outputString;
}

@end
