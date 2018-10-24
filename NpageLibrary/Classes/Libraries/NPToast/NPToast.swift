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
    var mutableArray: [AnyHashable] = []
    
    public static let shared: NPToast = NPToast()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.isUserInteractionEnabled = false
    }
    
    public func show(target: UIViewController!, message: String!) {
        let toastView: NPToastView = NPToastView.fromNib()
        mutableArray.append(toastView)
        
        toastView.show(target: self, message: message)
        self.view.addSubview(toastView)
        
        let topViewController = topViewControllerWithRootViewController(rootViewController: target)
        
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
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
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
