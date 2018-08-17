//
//  NPLocalizationUtil.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 13..
//

import UIKit

public enum kLanguage : Int {
    case English = 0
    case Korean = 1
    case NorthAmerica = 2
    case Europe = 3
    case EastMidlands = 4
    case China = 5
}

public class NPLocalizationUtil: NSObject {
    
    public static let shared = NPLocalizationUtil()
    
    public var currentLanguage: kLanguage = .English

    func getString(key: String!) -> String! {
        var fileName = ""
        // 사용자의 언어(기본 English)
        switch currentLanguage {
        case .Korean:
            fileName = "LanguageKR"
        case .NorthAmerica:
            fileName = "LanguageNA"
        case .Europe:
            fileName = "LanguageEU"
        case .EastMidlands:
            fileName = "LanguageEM"
        case .China:
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
public class NPLocalizationButton: UIButton {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String? {
        didSet {
            chageText()
        }
    }
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            chageText()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        chageText()
    }
    
    private func chageText() {
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
    
    @IBInspectable var localizedText: String? {
        didSet {
            chageText()
        }
    }
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            chageText()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        chageText()
    }
    
    private func chageText() {
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
    
    @IBInspectable var localizedText: String? {
        didSet {
            chageText()
        }
    }
    @IBInspectable var localizedPlaceholder: String? {
        didSet {
            chageText()
        }
    }
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            chageText()
        }
    }
    
    private func chageText() {
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
public class NPLocalizationTextView: UITextView {
    var localZationUtil: NPLocalizationUtil = NPLocalizationUtil.shared
    
    @IBInspectable var localizedText: String? {
        didSet {
            chageText()
        }
    }
    @IBInspectable var currentLanguage: Int = kLanguage.English.rawValue {
        didSet {
            chageText()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        chageText()
    }
    
    private func chageText() {
        if localizedText == nil {
            return
        }
        
        let string = localZationUtil.getString(key: localizedText)
        self.text = string
        setNeedsDisplay()
    }
}
