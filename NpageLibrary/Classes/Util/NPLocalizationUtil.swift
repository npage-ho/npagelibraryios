//
//  NPLocalizationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 13..
//

import UIKit

public enum kLanguage : Int {
    case EN = 0 //English
    case KR = 1 // Korean
    case NA = 2 // NorthAmerica
    case EU = 3 // Europe
    case EM = 4 // EastMidlands
    case CN = 5 // China
    
    var description: String {
        return String(describing: self)
    }
}

public class NPLocalizationUtil: NSObject {
    public static let languages: [kLanguage] = [.EN, .KR, .CN]

    public static let shared = NPLocalizationUtil()
    
    public var currentLanguage: kLanguage = .EN

    public func getString(key: String!) -> String! {
        var fileName = ""
        // 사용자의 언어(기본 English)
        switch currentLanguage {
        case .KR:
            fileName = "LanguageKR"
        case .NA:
            fileName = "LanguageNA"
        case .EU:
            fileName = "LanguageEU"
        case .EM:
            fileName = "LanguageEM"
        case .CN:
            fileName = "LanguageCN"
        default:
            fileName = "LanguageUS"
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
