//
//  NPUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

import UIKit

public class NPUtil: NSObject {
    public class func isNull(_ string: String?) -> Bool {
        if string == nil || string!.isEmpty || string!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            return true
        }
        return false
    }
    
    public class func urlDecode(_ string: String?) -> String? {
        return string?.removingPercentEncoding?.replacingOccurrences(of: "+", with: " ")
    }
    
    public class func urlDecodeDictionary(_ jsonDic: [String: Any]!) -> [String : Any]? {
        var dictionary: [String : Any] = [:]
        for key: String in jsonDic.keys {
            if ((jsonDic[key] as? [String: Any]) != nil) {
                dictionary[key] = NPUtil.urlDecodeDictionary(jsonDic?[key] as? [String : Any])
            } else if ((jsonDic[key] as? [Any]) != nil) {
                dictionary[key] = NPUtil.urlDecodeArray(jsonDic?[key] as? [Any])
            } else if ((jsonDic[key] as? String) != nil) {
                dictionary[key] = NPUtil.urlDecode(jsonDic?[key] as? String)
            } else {
                dictionary[key] = jsonDic?[key]
            }
        }
        return dictionary
    }
    
    public class func urlDecodeArray(_ array: [Any]!) -> [Any]? {
        var mutableArray: [Any] = []
        for i in 0..<(array?.count ?? 0) {
            if (array?[i] is [AnyHashable : Any]) {
                mutableArray.append(NPUtil.urlDecodeDictionary(array[i] as? [String: Any]) as Any)
            } else if (array?[i] is [Any]) {
                if let anI = NPUtil.urlDecodeArray(array?[i] as? [Any]) {
                    mutableArray.append(anI as Any)
                }
            } else if (array?[i] is String) {
                mutableArray.append(NPUtil.urlDecode(array?[i] as? String)!)
            } else {
                mutableArray.append(array?[i] as! AnyHashable)
            }
        }
        return mutableArray
    }
    
    public class func getStringFromDic(dic:[String:String], key:String!) -> String! {
        if dic[key] != nil {
            return dic[key]
        }
        return ""
    }
}
