//
//  NSString+EncryptionExtension.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

/*
 Usage
 
 var testString = "This is Test!"
 print("1 : \(testString)")
 
 let encrypString = testString.encryp()
 print("2 : \(encrypString)")
 
 let decrypString = encrypString?.decryp()
 print("3 : \(decrypString)")
 
 */
import UIKit

extension String {
    public func encrypAes256(_ key: String = AES256_SECRET_KEY) -> String? {
        if let data = self.data(using: .utf8), let encryptedData = NSData(data: data).aes256Encrypt(withKey: key) {
            return encryptedData.base64EncodedString()
        }
        return nil
    }
    
    public func decrypAes256(_ key:String = AES256_SECRET_KEY) -> String? {
        if let data = NSData(base64Encoded: self, options: []), let decrypedData = data.aes256Decrypt(withKey: key) {
            return String(data: decrypedData, encoding: .utf8)
        }
        return nil
    }
}
