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
    
    public func addIndicatorView(target: UIViewController) {
        let windowTypes = [target.tabBarController, target.navigationController, target]
        for vc in windowTypes {
            if vc != nil {
                var isHasIndicator = false
                for view in (vc?.view.subviews)! {
                    if view is NPLoadingIndicator {
                        isHasIndicator = true
                        vc?.view.bringSubview(toFront: NPLoadingIndicator.shared)
                        break
                    }
                }
                
                if isHasIndicator == false {
                    vc?.view.addSubview(NPLoadingIndicator.shared)
                    break
                }
            }
        }
    }
    
    public func showWithKey(key: String?) {
        if key != nil {
            arrayKey.append(key!)
        }
        self.isHidden = false
    }
    
    public func hideWithKey(key: String?) {
        if key != nil {
            if arrayKey.contains(key!) {
                if let index = arrayKey.index(of: key!) {
                    arrayKey.remove(at: index)
                }
                if arrayKey.count == 0 {
                    self.isHidden = true
                }
            }
        } else {
            self.isHidden = true
        }
    }
}
