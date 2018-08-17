//
//  NPAlertUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

public class NPAlertUtil: NSObject {
    
    public static func showAlert(message: String) {
        UIAlertController.showAlert(message)
    }
    
    public static func showAlert(title: String, message: String) {
        UIAlertController.showAlert(title, message)
    }
    
    public static func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        UIAlertController.showAlert(title: title, message: message, actions: actions)
    }
}

extension UIAlertController {
    
    static func showAlert(_ message: String) {
        showAlert(title: "", message: message, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
    
    static func showAlert(_ title: String, _ message: String) {
        showAlert(title: "", message: message, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
    
    static func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            for action in actions {
                alert.addAction(action)
            }
            
            if let topViewController = UIApplication.topViewController() {
                topViewController.present(alert, animated: true, completion: nil)
            } else {
                NPLog.i("NPAlertUtil cannot find Top ViewController")
            }
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
