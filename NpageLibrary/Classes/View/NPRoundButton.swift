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
    @IBInspectable public dynamic var highlightBgColor: UIColor?
    @IBInspectable public dynamic var selectedBgColor: UIColor?
    @IBInspectable public dynamic var lineWidth: Int = 0
    @IBInspectable public dynamic var fillColor: UIColor = UIColor.clear
    
    override open var isHighlighted: Bool {
        didSet {
            if self.highlightBgColor != nil {
                backgroundColor = isHighlighted ? self.highlightBgColor : self.backgroundColor
            }
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            if self.selectedBgColor != nil {
                backgroundColor = isSelected ? self.selectedBgColor : self.backgroundColor
            }
        }
    }
    
    open override func draw(_ rect: CGRect) {
        self.layer.borderColor = fillColor.cgColor
        self.layer.borderWidth = CGFloat(lineWidth)
        self.clipsToBounds = true
    }
    
    
}
