//
//  NPRoundButton.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 10..
//

import UIKit

@IBDesignable
public class NPRoundButton: UIButton {
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    @IBInspectable var lineWidth: Int = 0
    @IBInspectable var fillColor: UIColor = UIColor.clear
    
    override public func draw(_ rect: CGRect) {
        self.layer.borderColor = fillColor.cgColor
        self.layer.borderWidth = CGFloat(lineWidth)
        self.clipsToBounds = true
    }
}
