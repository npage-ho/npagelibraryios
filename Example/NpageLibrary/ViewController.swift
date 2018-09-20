//
//  ViewController.swift
//  NpageLibrary
//
//  Created by ho on 08/09/2018.
//  Copyright (c) 2018 ho. All rights reserved.
//

import UIKit
import NpageLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NPToast.shared.show(target: self, message: "toast Message")
        
        
        for language in NPLocalizationUtil.languages {
            print(language)
        }
        
        NPHttpRequest().post(_target: self, _urlString: "http://api.omnicommerce.co.kr:8045/api/checkVersion", _bodyObject: ["":""], _successBlock: { jsonDic in
            
            guard let response = jsonDic?["response"] as? [String: String] else {
                return
            }
            
        }, _failBlock: {code in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
