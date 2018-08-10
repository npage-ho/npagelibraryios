//
//  NSString+Sha256.h
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

#import <Foundation/Foundation.h>

@interface NSString (Sha256)

-(NSString*) hmacSHA256EncryptString;

@end
