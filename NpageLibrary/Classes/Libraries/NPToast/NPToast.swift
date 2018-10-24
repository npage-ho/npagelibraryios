//
//  NPToast.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 20..
//

/*
 Usage
 
 NPToast.shared.show(target: self, message: "message")
 
 */

import UIKit

public class NPToast: UIViewController {
    
    public static let shared: NPToast = NPToast()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
    }
    
    public func show(target: UIViewController!, message: String!) {
        let toastView: NPToastView = NPToastView.fromNib()
        
        toastView.show(target: self, message: message)
        self.view.addSubview(toastView)
        
        let topViewController = NPUtil.topViewControllerWithRootViewController(rootViewController: target)
        
        var isHasIndicator = false
        for view in (topViewController?.view.subviews)! {
            if view.isKind(of: NPToastView.self) {
                isHasIndicator = true
                topViewController?.view.bringSubview(toFront: self.view)
                break
            }
        }
        
        if isHasIndicator == false {
            topViewController?.view.addSubview(self.view)
        }
    }
}
