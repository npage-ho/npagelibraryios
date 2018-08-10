//
//  NSData+AES.h
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

#define AES256_SECRET_KEY @"0213755993FEAEAC51CAAAFDC5E0F77A"

/* Use example
 NSString *key = @"abcdefghijklmnopqrstuvwxyz123456";
 
 NSData *cipherData;
 NSString *base64Text, *plainText;
 
 // encrypt
 plainText  = @"Test English...";
 cipherData = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key];
 base64Text = [cipherData base64EncodedString];
 NSLog(@"%@", base64Text);
 
 // decrypt
 //    base64Text = @"gOXlygE+qxS+69zN5qC6eKJvMiEoDQtdoJb3zjT8f/E=";
 cipherData = [base64Text base64DecodedData];
 plainText  = [[NSString alloc] initWithData:[cipherData AES256DecryptWithKey:key] encoding:NSUTF8StringEncoding];
 NSLog(@"%@", plainText);
 */

#import <Foundation/Foundation.h>

@interface NSData (AES)

- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;

@end
