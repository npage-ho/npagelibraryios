//
//  NPExtensionView.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 20..
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        if let resources = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil) {
            return resources[0] as! T
        } else if let resources = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil) {
            return resources[0] as! T
        }
        return NSException(name: NSExceptionName("Xib not found Exception"), reason: "Cannot find Nib", userInfo: nil) as! Error as! T
    }
}
