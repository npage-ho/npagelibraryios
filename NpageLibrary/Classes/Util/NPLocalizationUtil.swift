//
//  NPLocalizationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 13..
//

import UIKit

public enum kLanguage : Int {
    case EN = 0 // English
    case FR = 1 // French
    case KO = 2 // Korean
    case PO = 3 // Protuges
    case ZH = 4 // Chinese
    case ES = 5 // 스페인어
    case RU = 6 // Russia
    case AE = 7 // UNITEDARABEMIRATES
    
    var description: String {
        return String(describing: self)
    }
}

public class NPLocalizationUtil: NSObject {
    public static let languages: [kLanguage] = [.EN, .FR, .KO, .PO, .ZH, .ES, .RU, .AE]

    public static let shared = NPLocalizationUtil()
    
    public var currentLanguage: kLanguage = .EN
    
    public func getStr(key: String?) -> String! {
        return getStr(key: key, curLang: currentLanguage)
    }
    
    public func getStr(key: String?, curLang: kLanguage) -> String! {
        var fileName = "LanguageEN"
        // 사용자의 언어(기본 English)
        switch curLang {
        case .EN:
            fileName = "LanguageEN"
            break
        case .FR:
            fileName = "LanguageFR"
            break
        case .KO:
            fileName = "LanguageKO"
            break
        case .PO:
            fileName = "LanguagePO"
            break
        case .ZH:
            fileName = "LanguageZH"
            break
        case .ES:
            fileName = "LanguageES"
            break
        case .RU:
            fileName = "LanguageRU"
            break
        case .AE:
            fileName = "LanguageAE"
            break
        }
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            let dictionary = NSDictionary(contentsOfFile: path)!
            let value = dictionary[key ?? ""] as? String
            if !NPUtil.isNull(value) {
                return value
            } else {
                return key
            }
        } else {
            return key
        }
    }

    public func getString(key: String?) -> String! {
        let value = getStr(key: key)
        if value == key && currentLanguage != .EN {
            return getStr(key: key, curLang: .EN)
        } else if !NPUtil.isNull(value) {
                return value
        } else {
            return value
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
        if let text = localizedText {
            let string = localZationUtil.getString(key: text)
            self.setTitle(string, for: .normal)
            setNeedsDisplay()
        }
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
        if let text = localizedText {
            let string = localZationUtil.getString(key: text)
            self.text = string
            setNeedsDisplay()
        }
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
        if let text = localizedText {
            let string = localZationUtil.getString(key: text)
            self.text = string
            setNeedsDisplay()
        }
    }
    
    private func reloadPlaceholder() {
        if let text = localizedPlaceholder {
            let placeholder = localZationUtil.getString(key: text)
            self.placeholder = placeholder
            setNeedsDisplay()
        }
        
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
        if let text = localizedText {
            let string = localZationUtil.getString(key: text)
            self.text = string
            setNeedsDisplay()
        }
    }
}
