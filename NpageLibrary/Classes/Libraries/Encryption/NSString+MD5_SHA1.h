//
//  NSString+MD5_SHA1.h
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

#import <Foundation/Foundation.h>

@interface NSString (MD5_SHA1)

- (NSString *) sha1HexDigest;
- (NSString *) md5HexDigest;

@end
