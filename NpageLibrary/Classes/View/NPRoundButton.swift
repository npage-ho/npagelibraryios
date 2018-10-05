//
//  NPRoundButton.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

@IBDesignable
open class NPRoundButton: NPLocalizationButton {
    @IBInspectable
    public dynamic var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    var defaultBgColor: UIColor?
    @IBInspectable public dynamic var highlightBgColor: UIColor?
    @IBInspectable public dynamic var selectedBgColor: UIColor?
    @IBInspectable public dynamic var lineWidth: Int = 0
    @IBInspectable public dynamic var fillColor: UIColor = UIColor.clear
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultBgColor = self.backgroundColor
    }
    
    override open var isHighlighted: Bool {
        didSet {
            if self.highlightBgColor != nil {
                backgroundColor = isHighlighted ? self.highlightBgColor : defaultBgColor
            }
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            if self.selectedBgColor != nil {
                backgroundColor = isSelected ? self.selectedBgColor : defaultBgColor
            }
        }
    }
    
    open override func draw(_ rect: CGRect) {
        self.layer.borderColor = fillColor.cgColor
        self.layer.borderWidth = CGFloat(lineWidth)
        self.clipsToBounds = true
    }
    
    
}
