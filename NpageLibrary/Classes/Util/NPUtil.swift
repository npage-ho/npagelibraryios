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
    
    public class func urlDecode(string: String?) -> String? {
        return string?.removingPercentEncoding?.replacingOccurrences(of: "+", with: " ")
    }
    
    public class func urlDecode(dictionary: [String: Any]!) -> [String : Any]? {
        var mutableDictionary: [String : Any] = [:]
        for key: String in dictionary.keys {
            if let value = dictionary[key] as? [String: Any] {
                mutableDictionary[key] = NPUtil.urlDecode(dictionary: value)
            } else if let value = dictionary[key] as? [Any] {
                mutableDictionary[key] = NPUtil.urlDecode(array: value)
            } else if let value = dictionary[key] as? String {
                mutableDictionary[key] = NPUtil.urlDecode(string: value)
            } else {
                mutableDictionary[key] = dictionary[key]
            }
        }
        return mutableDictionary
    }
    
    public class func urlDecode(array: [Any]) -> [Any]? {
        var mutableArray: [Any] = []
        for i in 0..<array.count {
            if let value = array[i] as? [String: Any] {
                mutableArray.append(NPUtil.urlDecode(dictionary: value) as Any)
            } else if let value = array[i] as? [Any] {
                mutableArray.append(NPUtil.urlDecode(array: value) as Any)
            } else if let value = array[i] as? String {
                mutableArray.append(NPUtil.urlDecode(string: value) as Any)
            } else {
                mutableArray.append(array[i])
            }
        }
        return mutableArray
    }
    
    public class func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
}
