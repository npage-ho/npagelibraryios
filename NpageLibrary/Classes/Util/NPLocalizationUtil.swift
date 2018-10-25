//
//  NPLocalizationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 13..
//

import UIKit

public enum kLanguage : Int {
    case EN = 0 //English
    case FR = 1 // French
    case KO = 2 // Korean
    case PO = 3 // Protuges
    case ZH = 4 // Chinese
    case ES = 5 // 스페인어
    
    var description: String {
        return String(describing: self)
    }
}

public class NPLocalizationUtil: NSObject {
    public static let languages: [kLanguage] = [.EN, .FR, .KO, .PO, .ZH, .ES]

    public static let shared = NPLocalizationUtil()
    
    public var currentLanguage: kLanguage = .EN

    public func getString(key: String!) -> String! {
        var fileName = ""
        // 사용자의 언어(기본 English)
        switch currentLanguage {
        case .EN:
            fileName = "LanguageEN"
        case .FR:
            fileName = "LanguageFR"
        case .KO:
            fileName = "LanguageKO"
        case .PO:
            fileName = "LanguagePO"
        case .ZH:
            fileName = "LanguageZH"
        case .ES:
            fileName = "LanguageES"
        default:
            fileName = "LanguageEN"
        }
        let path = Bundle.main.path(forResource: fileName, ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)!
        let value = dictionary[key] as? String
        if value != nil && (value?.count ?? 0) > 0 {
            return value
        } else {
            return key
        }
    }
}

@IBDesignable
open class NPLocalizationButton: UIButton {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String?
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        reloadText()
    }
    
    open func reloadText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.setTitle(string, for: .normal)
        setNeedsDisplay()
    }
}

@IBDesignable
public class NPLocalizationLabel: UILabel {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        reloadText()
    }
    
    public func reloadText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
    }
}

@IBDesignable
public class NPLocalizationTextField: UITextField {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String?
    
    @IBInspectable var localizedPlaceholder: String?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        reloadText()
    }
    
    public func reloadText() {
        reloadPlaceholder()
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
    }
    
    private func reloadPlaceholder() {
        if localizedPlaceholder == nil {
            return
        }
        
        let placeholder = localZationUtil.getString(key: localizedPlaceholder)
        self.placeholder = placeholder
        setNeedsDisplay()
    }
}

@IBDesignable
public class NPLocalizationTextView: UITextView {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        reloadText()
    }
    
    public func reloadText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
    }
}
