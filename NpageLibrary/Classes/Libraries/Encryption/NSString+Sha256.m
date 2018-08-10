//
//  NSString+Sha256.m
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

#import "NSString+Sha256.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"

@implementation NSString (Sha256)

-(NSString*) hmacSHA256EncryptString {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[64];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:64];
    for(int i = 0; i < 32; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    NSLog(@"SHA256 : %@", output);
    return output;
    
}

@end
