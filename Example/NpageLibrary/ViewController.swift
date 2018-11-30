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
        
        NPLocalizationUtil.shared.currentLanguage = .EN

        NPToast.shared.show(target: self, message: "this is long long string test!! this is long long string test!! this is long long string test!! ENDthis is long long string test!! this is long long string test!! this is long long string test!! END")
//        
//        
//        for language in NPLocalizationUtil.languages {
//            NPToast.shared.show(target: self, message: "this is test\nmessage")
//        }
        

        NPHttpRequest().post(_target: self, _urlString: "http://192.168.0.15:8090/partsbk/mobileApi/50", _bodyObject: ["":""], _successBlock: { jsonDic in
            guard let response = jsonDic?["data"] as? [String: Any] else {
                return
            }
            
            if let boardList = response["boardList"] as? [[String: Any]] {
                for dictionary in boardList {
                    if let title = dictionary["title"] as? String, title.contains("박정원") {
                        print("boardLog : \(dictionary)")
                    }
                }
            }

        }, _failBlock: {code in

        })

    }
    
    @IBAction func onClickButton(_ sender: Any) {
        NPToast.shared.show(target: self, message: "onClickButton")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
