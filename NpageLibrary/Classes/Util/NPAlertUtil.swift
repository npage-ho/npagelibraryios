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
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        
        if let topViewController = NPUtil.topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController) {
            topViewController.present(alert, animated: true, completion: nil)
        } else {
            NPLog.i("NPAlertUtil cannot find Top ViewController")
        }
    }
}
