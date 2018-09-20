//
//  NPHttpRequest.swift
//  FBSnapshotTestCase
//
//  Created by Cheolho on 2018. 8. 9..
//

/*
 Usage
 
 NPHttpRequest().post(_target: self, _urlString: "http://api.omnicommerce.co.kr:8045/api/checkVersion", _bodyObject: ["":""], _successBlock: { jsonDic in
 
    guard let response = jsonDic?["response"] as? [String: String] else {
        return
    }
 
 }, _failBlock: {code in
 
 })
 
 */

import UIKit

let TIME_OUT_INTERVAL: Double = 30

public class NPHttpRequest: NSObject, URLSessionDataDelegate {
    var target: UIViewController!
    var urlString: String!
    var headerObject: [String: String]?
    var bodyObject: [String: String]?
    var successKey: String!
    var successCode: Int!
    
    var successBlock: (([String : Any]) -> Void)?
    var failBlock: ((Int) -> Void)?
    
    var receiveData : NSMutableData?
    var defaultSession : URLSession?
    
    public override init() {
        super.init()
    }
    
    public func post(_target: UIViewController!, _urlString: String, _bodyObject: [String: String]?, _successBlock: @escaping (_ jsonDic: [String : Any]?) -> Void, _failBlock: @escaping (_ code: (Int)?) -> Void, _ _successKey: String = "code", _ _successCode: String = "200") {
        post(_target: _target, _urlString: _urlString, _header: nil, _bodyObject: _bodyObject, _successBlock: _successBlock, _failBlock: _failBlock)
    }
    
    public func post(_target: UIViewController!, _urlString: String, _header: [String: String]?, _bodyObject: [String: String]?, _successBlock: @escaping (_ jsonDic: [String : Any]?) -> Void, _failBlock: @escaping (_ code: (Int)?) -> Void, _ _successKey: String = "code", _ _successCode: Int = 200) {
        target = _target
        urlString = _urlString
        headerObject = _header
        bodyObject = _bodyObject
        
        successBlock = _successBlock
        failBlock = _failBlock
        
        successKey = _successKey
        successCode = _successCode
        
        NPLoadingIndicator.shared.addIndicatorView(target: target)
        
        NPLoadingIndicator.shared.showWithKey(key: urlString)
        
        print("url : \(_urlString)")
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.sessionSendsLaunchEvents = true
        sessionConfig.isDiscretionary = true
        defaultSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)
        var request: URLRequest? = nil
        if let aString = URL(string: _urlString) {
            request = URLRequest(url: aString, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TIME_OUT_INTERVAL)
        }
        request?.httpShouldHandleCookies = false
        request?.httpMethod = "POST"
        
        request?.allHTTPHeaderFields = _header
        
        if let body = _bodyObject {
            var array = [String]()
            for key in body.keys {
                if !key.isEmpty {
                    array.append("\(key)=\(body[key] ?? "")")
                }
            }
            print("body : \(array)")
            request?.httpBody = array.joined(separator: "&").data(using: .utf8)
            if let aBody = request?.httpBody {
                print("body : \(String(data: aBody, encoding: .utf8) ?? "")")
            }
        }
        let dataTask: URLSessionDataTask? = defaultSession?.dataTask(with: (request)!)
        dataTask?.resume()
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receiveData?.append(data)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        defaultSession?.finishTasksAndInvalidate()
        
        receiveData = nil
        receiveData = NSMutableData()
        receiveData?.length = 0
        
        completionHandler(.allow)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        NPLoadingIndicator.shared.hideWithKey(key: urlString)
        
        if error == nil {
            let str : String = String.init(data: receiveData! as Data, encoding: String.Encoding.utf8)!
            //            print("jsonString : \(str)")
            connectionDidFinish(str)
        } else {
            showFailAlert(error: error)
        }
    }
    
    func connectionDidFinish(_ text : String) {
        if let anEncoding = text.data(using: .utf8) {
            do {
                let jsonDic = try NPUtil.urlDecodeDictionary(JSONSerialization.jsonObject(with: anEncoding, options: [.allowFragments, .mutableContainers]) as? [String: Any])
//                print("jsonDic : \(String(describing: jsonDic))")
                
                if let statusCode = jsonDic![successKey] as? Int {
                    if statusCode == successCode {
                        successBlock!(jsonDic!)
                    } else {
                        showFailAlert(code: Int(statusCode))
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func showFailAlert(error: Error?) {
        let errorMessage: String = (error?.localizedDescription)!
        print("error : \(String(describing: error ?? nil))")
        var actions: [UIAlertAction]! = []
        actions.append(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actions.append(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            self?.post(_target: self?.target, _urlString: (self?.urlString)!, _bodyObject: self?.bodyObject, _successBlock: self?.successBlock as! ([AnyHashable : Any]?) -> Void, _failBlock: self?.failBlock as! ((Int)?) -> Void)
        }))
        
        NPAlertUtil.showAlert(title: "Network Error", message: "A network error occurred.\nError : \(errorMessage)\nDo you want to retry?", actions: actions)
    }
    
    func showFailAlert(code: Int!) {
        if code == 500 {
            NPAlertUtil.showAlert(title: "Network Error", message: "A server error has occurred. Please contact the manager\nCode : \(String(code!))")
        } else {
            failBlock!(code!)
        }
    }
}
