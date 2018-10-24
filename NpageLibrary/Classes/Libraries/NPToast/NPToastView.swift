//
//  NPToastView.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 10. 24..
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

public class NPToastView: UIView {
    @IBOutlet var viewGrayBg: UIView!
    @IBOutlet var lcViewLeft: NSLayoutConstraint!
    @IBOutlet var lcViewTop: NSLayoutConstraint!
    @IBOutlet var lcViewWidth: NSLayoutConstraint!
    @IBOutlet var lcViewHeight: NSLayoutConstraint!
    @IBOutlet var labelMessage: UILabel!
    
    private var cancellation: Bool = false
        
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        viewGrayBg.layer.cornerRadius = 10
        viewGrayBg.clipsToBounds = true
        
        let screenFrame: CGRect = UIScreen.main.bounds
        let maxWidth = Int(screenFrame.size.width - 40)
        lcViewWidth.constant = CGFloat(maxWidth)
        
        lcViewLeft.constant = (screenFrame.size.width - lcViewWidth.constant) / 2
    }
    
    public func show(target: UIViewController!, message: String!) {
        labelMessage.text = message
        let screenFrame: CGRect = target.view.bounds
        let size: CGSize = labelMessage.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        lcViewWidth.constant = CGFloat(size.width + 40)
        lcViewHeight.constant = size.height + 40
        lcViewTop.constant = (screenFrame.size.height - lcViewHeight.constant) / 2
        lcViewLeft.constant = (screenFrame.size.width - lcViewWidth.constant) / 2
        
        let block: (() -> Void)? = {
            self.hide()
        }
        cancellation = false
        dispatch_with_cancellation(block: block, cancellation: cancellation)
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        cancellation = true
        self.hide()
    }
    
    func hide() {
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0
        }) { (completion) in
            self.removeFromSuperview()
        }
    }
}
