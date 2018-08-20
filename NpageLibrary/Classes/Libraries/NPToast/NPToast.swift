//
//  NPToast.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 20..
//

import UIKit

let SHOW_DURATION = 2.5

func dispatch_with_cancellation(block: (() -> Void)? , cancellation: Bool) {
    let time = DispatchTime.now() + SHOW_DURATION
    DispatchQueue.main.asyncAfter(deadline: time, execute: {
        if cancellation == false {
            if let aBlock = block {
                aBlock()
            }
        }
    })
}

public class NPToast: UIView {
    @IBOutlet var viewGrayBg: UIView!
    @IBOutlet var lcViewLeft: NSLayoutConstraint!
    @IBOutlet var lcViewTop: NSLayoutConstraint!
    @IBOutlet var lcViewWidth: NSLayoutConstraint!
    @IBOutlet var lcViewHeight: NSLayoutConstraint!
    @IBOutlet var labelMessage: UILabel!
    var mutableArray: [AnyHashable] = []
    
    private var cancellation: Bool = false
    
    public static let shared: NPToast = Bundle(for: NPToast.self).loadNibNamed(String(describing: NPToast.self), owner: nil, options: nil)![0] as! NPToast
    
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        mutableArray = [AnyHashable](repeating: 0, count: 0)
        viewGrayBg.layer.cornerRadius = 10
        viewGrayBg.clipsToBounds = true
        
        let screenFrame: CGRect = UIScreen.main.bounds
        let maxWidth = Int(screenFrame.size.width - 40)
        lcViewWidth.constant = CGFloat(maxWidth)
        
        lcViewLeft.constant = (screenFrame.size.width - lcViewWidth.constant) / 2
    }
    
    public func show(target: UIViewController!, message: String!) {
        labelMessage.text = message
        let screenFrame: CGRect = UIScreen.main.bounds
        let size: CGSize = labelMessage.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        lcViewHeight.constant = size.height + 40
        lcViewTop.constant = (screenFrame.size.height - lcViewHeight.constant) / 2
        
        let windowTypes = [target.tabBarController, target.navigationController, target]
        for vc in windowTypes {
            if vc != nil {
                var isHasIndicator = false
                for view in (vc?.view.subviews)! {
                    if view is NPToast {
                        isHasIndicator = true
                        vc?.view.bringSubview(toFront: NPToast.shared)
                        break
                    }
                }
                
                if isHasIndicator == false {
                    vc?.view.addSubview(NPToast.shared)
                    break
                }
            }
        }
        
        
        show(withKey: message)
        let block: (() -> Void)? = {
            self.hide(withKey: message)
        }
        cancellation = false
        dispatch_with_cancellation(block: block, cancellation: cancellation)
    }
    
    func show(withKey key: String?) {
        if let aKey = key {
            mutableArray.append(aKey)
        }
        self.isHidden = false
    }
    
    func hide(withKey key: String?) {
        if let aKey = key {
            if mutableArray.contains(aKey) {
                while let elementIndex = mutableArray.index(of: aKey) { mutableArray.remove(at: elementIndex) }
                if mutableArray.count == 0 {
                    self.isHidden = true
                }
            }
        } else {
            self.isHidden = true
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        cancellation = true
        hide(withKey: labelMessage.text)
    }
}
