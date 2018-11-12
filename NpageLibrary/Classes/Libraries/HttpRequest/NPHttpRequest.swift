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
    var isShowErrorCode: Bool = true

    var successBlock: ((_ jsonDic: [String : Any]?) -> Void)?
    var failBlock: ((_ code: (Int)?) -> Void)?
    
    var receiveData : NSMutableData?
    var defaultSession : URLSession?
    
    public override init() {
        super.init()
    }
    
    public func post(_target: UIViewController!, _urlString: String, _bodyObject: [String: String]?, _successBlock: @escaping (_ jsonDic: [String : Any]?) -> Void, _failBlock: @escaping (_ code: (Int)?) -> Void, _ _successKey: String = "code", _ _successCode: String = "200") {
        post(_target: _target, _urlString: _urlString, _bodyObject: _bodyObject, _successBlock: _successBlock, _failBlock: _failBlock, _isShowProgress: true, _isShowErrorCode: true)
    }
    
    public func post(_target: UIViewController!, _urlString: String, _bodyObject: [String: String]?, _successBlock: @escaping (_ jsonDic: [String : Any]?) -> Void, _failBlock: @escaping (_ code: (Int)?) -> Void, _ _successKey: String = "code", _ _successCode: String = "200", _isShowProgress: Bool = true, _isShowErrorCode: Bool = true) {
        post(_target: _target, _urlString: _urlString, _header: nil, _bodyObject: _bodyObject, _successBlock: _successBlock, _failBlock: _failBlock, _isShowProgress: _isShowProgress, _isShowErrorCode: _isShowErrorCode)
    }
    
    public func post(_target: UIViewController!, _urlString: String, _header: [String: String]?, _bodyObject: [String: String]?, _successBlock: @escaping (_ jsonDic: [String : Any]?) -> Void, _failBlock: @escaping (_ code: (Int)?) -> Void, _ _successKey: String = "code", _ _successCode: Int = 200, _isShowProgress: Bool, _isShowErrorCode: Bool) {
        target = _target
        urlString = _urlString
        headerObject = _header
        bodyObject = _bodyObject
        
        successBlock = _successBlock
        failBlock = _failBlock
        
        successKey = _successKey
        successCode = _successCode
        isShowErrorCode = _isShowErrorCode
        
        if _isShowProgress {
            NPLoadingIndicator.shared.show(target: target, key: urlString)
        }
        
        NPLog.d("url : \(_urlString)")
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
            NPLog.d("body : \(array)")
            request?.httpBody = array.joined(separator: "&").data(using: .utf8)
            if let aBody = request?.httpBody {
                NPLog.d("body : \(String(data: aBody, encoding: .utf8) ?? "")")
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
//        sleep(5)
        NPLoadingIndicator.shared.hide(key: urlString)
        
        if error == nil {
            let str : String = String.init(data: receiveData! as Data, encoding: String.Encoding.utf8)!
            //            NPLog.d("jsonString : \(str)")
            connectionDidFinish(str)
        } else {
            showFailAlert(error: error)
        }
    }
    
    func connectionDidFinish(_ text : String) {
        if let anEncoding = text.data(using: .utf8) {
            do {
                let jsonDic = try NPUtil.urlDecodeDictionary(JSONSerialization.jsonObject(with: anEncoding, options: [.allowFragments, .mutableContainers]) as? [String: Any])
//                NPLog.d("jsonDic : \(String(describing: jsonDic))")
                
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
        actions.append(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let _target = self.target, let _urlString = self.urlString, let _bodyObject = self.bodyObject, let _successBlock = self.successBlock, let _failBlock = self.failBlock {
                self.post(_target: _target, _urlString: _urlString, _bodyObject: _bodyObject, _successBlock: _successBlock, _failBlock: _failBlock)
            } else {
                NPLog.e("parameter wrong")
            }
        }))
        
        if isShowErrorCode {
            NPAlertUtil.showAlert(title: "Network Error", message: "A network error occurred.\nError : \(errorMessage)\nDo you want to retry?", actions: actions)
        } else {
            if error != nil {
                failBlock!((error! as NSError).code)
            } else {
                failBlock!(500)
            }
        }
    }
    
    func showFailAlert(code: Int!) {
        if code == 500 {
            if isShowErrorCode {
                NPAlertUtil.showAlert(title: "Network Error", message: "A server error has occurred. Please contact the manager\nCode : \(String(code!))")
            } else {
                failBlock!(code!)
            }
        } else {
            failBlock!(code!)
        }
    }
}
