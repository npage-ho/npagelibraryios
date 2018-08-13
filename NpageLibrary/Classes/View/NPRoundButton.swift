//
//  NPRoundButton.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

@IBDesignable
open class NPRoundButton: UIButton {
    @IBInspectable
    public dynamic var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable public dynamic var lineWidth: Int = 0
    @IBInspectable public dynamic var fillColor: UIColor = UIColor.clear
    
    open override func draw(_ rect: CGRect) {
        self.layer.borderColor = fillColor.cgColor
        self.layer.borderWidth = CGFloat(lineWidth)
        self.clipsToBounds = true
    }
}
