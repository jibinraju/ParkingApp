//
//  Service.swift
//  Parking
//
//  Created by Jibin Raju on 12/04/2018.
//  Copyright © 2018 Jibin Raju. All rights reserved.
//

import UIKit

class Service: Operation, IService {
    // MARK: - Properties
    var responseProcessor: IResponseProcessor?
    var urlSession: URLSession!
    
    // MARK: -
    init(responseProcessor: IResponseProcessor? = nil) {
        self.responseProcessor = responseProcessor
        super.init()
        self.initalizeSession()
    }
    
    // MARK: - IService Properties
    var requestURL: String! {
        return Constants.HTTP.Url.BasePath
    }
    
    var httpHeaderFields: Dictionary<String, String>! {
        let headerParameters = [Constants.HTTP.HeaderKey.Accept : Constants.HTTP.HeaderValue.ApplicationJSON,
                                Constants.HTTP.HeaderKey.ContentType : Constants.HTTP.HeaderValue.ApplicationJSON]
        return headerParameters
    }
    
    var bodyParameters: Dictionary<String, String>! {
        return [:]
    }
    
    var methodType: String! {
        return Constants.HTTP.MethodType.GET
    }
    
    // MARK: - Operations Accessors
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return _executing
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override func start() {
        guard isCancelled == false else {
            _finished = true
            return
        }
        
        _executing = true
        let urlRequest = prepareRequest(urlPath: requestURL, methodType: methodType, bodyParameters: bodyParameters, headerParameters: httpHeaderFields)
        guard urlRequest != nil else {
            finished()
            return
        }
        
        guard let urlSessionDataTask = urlSession.dataTask(with: urlRequest!) as URLSessionDataTask? else {
            finished()
            return
        }
        
        urlSessionDataTask.resume()
    }
    
    // MARK: - Private Accessors
    private var _executing: Bool = false {
        willSet{
            willChangeValue(forKey: "isExecuting")
        }
        
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished: Bool = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private func initalizeSession() {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = true
        configuration.httpShouldUsePipelining = false
        configuration.requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
        configuration.timeoutIntervalForRequest = Constants.HTTP.RequestTimeOut
        urlSession = URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    private func prepareRequest(urlPath: String, methodType: String, bodyParameters: Dictionary<String, String>, headerParameters: Dictionary<String, String>) -> URLRequest? {
        var urlRequest: URLRequest? = nil
        
        if urlPath.isEmpty || methodType.isEmpty {
            return urlRequest
        }
        
        let urlComponents = URLComponents.init(string: urlPath)
        urlRequest = URLRequest.init(url: (urlComponents?.url)!)
        if urlRequest == nil {
            return urlRequest
        }

        for (key, value) in headerParameters {
            urlRequest?.addValue(value, forHTTPHeaderField: key)
        }
        
        do {
            if bodyParameters.count > 0 {
                let bodyData = try JSONSerialization.data(withJSONObject: bodyParameters)
                urlRequest?.httpBody = bodyData
            }
        }
        catch {
            print("failed to serialized body parameters")
        }
        
        urlRequest?.httpMethod = methodType
        urlRequest?.timeoutInterval = Constants.HTTP.RequestTimeOut
        return urlRequest
    }
    
    private func finished() {
        _executing = false
        _finished = true
    }
}

// MARK: - URLSessionDataDelegate Extension
extension Service : URLSessionDataDelegate {

    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if let callBack = responseProcessor {
            callBack.didFailRecevingData(error: error!)
        }
       finished()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        let urlSessionAuthChallengePerformHandle = URLSession.AuthChallengeDisposition.performDefaultHandling
        let urlCredential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(urlSessionAuthChallengePerformHandle, urlCredential)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(URLSession.ResponseDisposition.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if let callBack = responseProcessor {
            callBack.didReceiveData(data: data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let callBack = responseProcessor {
            if error != nil {
                callBack.didFailRecevingData(error: error!)
            }
            else {
                callBack.didFinishReceivingData()
            }
        }
        finished()
    }
    
}
