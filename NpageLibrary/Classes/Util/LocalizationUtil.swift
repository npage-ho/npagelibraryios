//
//  LocalizationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 13..
//

import UIKit

enum kLanguage : Int {
    case English
    case Korean
}

class LocalizationUtil: NSObject {
    var currentLanguage: kLanguage = .English
    
    func getString(key: String!) -> String! {
        var fileName = ""
        // 사용자의 언어(기본 ENG)
        if currentLanguage == .Korean {
            fileName = "LanguageKor"
        } else {
            fileName = "LanguageEng"
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
public class LocalizationButton: UIButton {
    var localZationUtil: LocalizationUtil = LocalizationUtil()
    
    @IBInspectable var localizedText: String?
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            localZationUtil.currentLanguage = kLanguage(rawValue: currentLanguage)!
            setLocalizedText()
        }
    }
    
    private func setLocalizedText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.setTitle(string, for: .normal)
        setNeedsDisplay()
    }
}

@IBDesignable
public class LocalizationLabel: UILabel {
    var localZationUtil: LocalizationUtil = LocalizationUtil()
    
    @IBInspectable var localizedText: String?
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            localZationUtil.currentLanguage = kLanguage(rawValue: currentLanguage)!
            setLocalizedText()
        }
    }
    
    private func setLocalizedText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
    }
}

@IBDesignable
public class LocalizationTextField: UITextField {
    var localZationUtil: LocalizationUtil = LocalizationUtil()
    
    @IBInspectable var localizedText: String?
    @IBInspectable var localizedPlaceholder: String?
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            localZationUtil.currentLanguage = kLanguage(rawValue: currentLanguage)!
            setLocalizedText()
        }
    }
    
    private func setLocalizedText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
        
        if localizedPlaceholder == nil {
            return
        }
        
        let placeholder = localZationUtil.getString(key: localizedPlaceholder)
        self.placeholder = placeholder
    }
}

@IBDesignable
public class LocalizationTextView: UITextView {
    var localZationUtil: LocalizationUtil = LocalizationUtil()
    
    @IBInspectable var localizedText: String?
    @IBInspectable var localizedPlaceholder: String?
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            localZationUtil.currentLanguage = kLanguage(rawValue: currentLanguage)!
            setLocalizedText()
        }
    }
    
    private func setLocalizedText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
        
        if localizedPlaceholder == nil {
            return
        }
        
        let placeholder = localZationUtil.getString(key: localizedPlaceholder)
        self.placeholder = placeholder
    }
}
