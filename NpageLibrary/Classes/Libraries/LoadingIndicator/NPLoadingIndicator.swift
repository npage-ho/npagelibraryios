//
//  NPLoadingIndicator.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

import UIKit

class NPLoadingIndicator: UIView {
    @IBOutlet weak var viewBg: UIView!
    
    var arrayKey = Array<String>()
    
    static let shared: NPLoadingIndicator = .fromNib()

    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewBg.layer.cornerRadius = 10
        viewBg.clipsToBounds = true
        
        viewBg.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func addIndicatorView(target: UIViewController) {
        let windowTypes = [target.tabBarController, target.navigationController, target]
        for vc in windowTypes {
            if vc != nil {
                var isHasIndicator = false
                for view in (vc?.view.subviews)! {
                    if view is NPLoadingIndicator {
                        isHasIndicator = true
                        break
                    }
                }
                
                if isHasIndicator == false {
                    vc?.view.addSubview(NPLoadingIndicator.shared)
                    break
                }
            }
        }
    }
    
    func showWithKey(key: String?) {
        if key != nil {
            arrayKey.append(key!)
        }
        self.isHidden = false
    }
    
    func hideWithKey(key: String?) {
        if key != nil {
            if arrayKey.contains(key!) {
                if let index = arrayKey.index(of: key!) {
                    arrayKey.remove(at: index)
                }
                if arrayKey.count == 0 {
                    self.isHidden = true
                }
            }
        } else {
            self.isHidden = true
        }
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
