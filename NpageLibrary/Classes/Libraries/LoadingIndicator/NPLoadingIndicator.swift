//
//  NPLoadingIndicator.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

import UIKit

public class NPLoadingIndicator: UIView {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lcLeading: NSLayoutConstraint!
    @IBOutlet weak var lcTop: NSLayoutConstraint!
    
    var arrayKey = Array<String>()
    
    public static let shared: NPLoadingIndicator = .fromNib()

    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        viewBg.layer.cornerRadius = 10
        viewBg.clipsToBounds = true
        
        let screenFrame = UIScreen.main.bounds
        
        lcLeading.constant = (screenFrame.size.width - viewBg.frame.size.width) / 2
        lcTop.constant = (screenFrame.size.height - viewBg.frame.size.height) / 2
        
        UIView.animate(withDuration: 0) {
            self.layoutIfNeeded()
        }
    }
    
    public func show(target: UIViewController, key: String?) {
        let topViewController = NPUtil.topViewControllerWithRootViewController(rootViewController: target)
        
        var isHasIndicator = false
        for view in (topViewController?.view.subviews)! {
            if view is NPLoadingIndicator {
                isHasIndicator = true
                topViewController?.view.bringSubview(toFront: NPLoadingIndicator.shared)
                break
            }
        }
        
        if isHasIndicator == false {
            topViewController?.view.addSubview(NPLoadingIndicator.shared)
        }
        
        if key != nil {
            arrayKey.append(key!)
        }
        DispatchQueue.main.async {
            self.isHidden = false
        }
    }
    
    public func hide(key: String?) {
        if key != nil {
            if arrayKey.contains(key!) {
                if let index = arrayKey.index(of: key!) {
                    arrayKey.remove(at: index)
                }
                if arrayKey.count == 0 {
                    DispatchQueue.main.async {
                        self.isHidden = true
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.isHidden = true
            }
        }
    }
}
