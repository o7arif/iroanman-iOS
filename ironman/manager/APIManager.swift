//
//  APIManager.swift
//  ironman
//
//  Created by Md Nazmul Haque Arif on 11/10/21.
//

import Alamofire
import Toaster

struct Networking {
    
    static let instance = Networking()
    
    func getHeaders() -> Any {
        let bearerToken = CacheData.instance.getToken()
        let HTTPHeaders = ["Accept": "application/json", "Authorization": "Bearer \(bearerToken)"] as [String:AnyObject]
        return HTTPHeaders
    }
    
    func getMultipartHeaders() -> Any {
        let bearerToken = CacheData.instance.getToken()
        let HTTPHeaders = ["Accept": "application/json", "Content-type": "multipart/form-data",
                           "Authorization": "Bearer \(bearerToken)","Content-Disposition": "form-data"] as [String:AnyObject]
        return HTTPHeaders
    }
    
    func call(api : String, method: HTTPMethod, parameters: [String:Any], encoding: ParameterEncoding? = URLEncoding.default, completion: @escaping (ResponseModel) -> ()) {
       
        print(parameters)
        
        let manager = Alamofire.SessionManager.default
        manager.retrier = NetworkRequestRetrier()
        manager.session.configuration.timeoutIntervalForRequest = 10 //timeout
        manager.session.configuration.timeoutIntervalForResource = 10
        
        manager.request(AppConst.BASE_URL + api, method: method, parameters: parameters as Parameters, encoding: encoding ?? URLEncoding.httpBody, headers: getHeaders() as? HTTPHeaders).responseJSON { response in
            
            print("parameters:\(parameters)")
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                
                switch response.result {
                case .success:
                    print(response.result.value ?? "")
                    switch(response.response?.statusCode ?? 0) {
                    
                    case 200..<300:
                        completion(ResponseModel.init(code: 200, body: response.result.value as! NSDictionary))
                        break;
                        
                    case 401:
                        if (api != "/login" && api != "/password/reset" && api != "/otp/verify") {
                            print("login korao")
                            CacheData.instance.destroySession()
                            break
                        } else {
                            let responseModel = ResponseModel.init(code: 401, body: response.result.value as! NSDictionary)
                            completion(responseModel)
                        }
                    default:
                        let mainDictionary = response.result.value as! NSDictionary
                        
                        var errors: [ErrorModel] = []
                        if let errorsDictionary = mainDictionary["errors"] as? [String: [String]] {
                            for (key, value) in errorsDictionary {
                                print(key, value[0])
                                let errorModel = ErrorModel.init(fieldName: key, message: value[0])
                                errors.append(errorModel)
                            }
                        }
                        
                        var message = mainDictionary["message"] as? String
                        if message == nil || message!.isEmpty {
                            message = mainDictionary["exception"] as? String
                        }
                        completion(ResponseModel.init(code: response.response?.statusCode ?? 0, body: mainDictionary, message: message, errors: errors))
                        break;
                    }
                    break
                case .failure(let error):
                    let str = String(decoding: response.data!, as: UTF8.self)
                    print(str)
                    print(error.localizedDescription)
                    completion(ResponseModel.init(code: response.response?.statusCode ?? 0, body: [:], message:error.localizedDescription))
                }
            }
        }
    }
    
    
    
    func callMutipartMultipleFilesWithParameters(api: String, method: HTTPMethod, imageDatas: [Data], dataKey: String, parameters: [String:Any], completion: @escaping (ResponseModel?) -> ()) {
        let url = AppConst.BASE_URL + api
        let headers: HTTPHeaders = getMultipartHeaders() as! HTTPHeaders
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Float {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Double {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        } else if let num = element as? Float {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        } else if let num = element as? Double {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            for data in imageDatas {
                multipartFormData.append(data, withName: dataKey, fileName: String(Int(Date().timeIntervalSince1970)) + String(Int.random(in: 0..<1000)) + ".jpeg", mimeType: "image/jpeg")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: method, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
                    switch(response.response?.statusCode ?? 0) {
                    
                    case 200..<300:
                        completion(ResponseModel.init(code: 200, body: response.result.value as! NSDictionary))
                        break;
                        
                    case 401:
                        if (api != "/login" && api != "/password/reset" && api != "/otp/verify") {
                            CacheData.instance.destroySession()
                            break
                        } else {
                            let responseModel = ResponseModel.init(code: 401, body: response.result.value as! NSDictionary)
                            completion(responseModel)
                        }
                        
                    default:
                        let mainDictionary = response.result.value as! NSDictionary
                        
                        var errors: [ErrorModel] = []
                        if let errorsDictionary = mainDictionary["errors"] as? [String: [String]] {
                            for (key, value) in errorsDictionary {
                                print(key, value[0])
                                let errorModel = ErrorModel.init(fieldName: key, message: value[0])
                                errors.append(errorModel)
                            }
                        }
                        
                        var message = mainDictionary["message"] as? String
                        if message == nil || message!.isEmpty {
                            message = mainDictionary["exception"] as? String
                        }
                        completion(ResponseModel.init(code: response.response?.statusCode ?? 0, body: mainDictionary, message: message, errors: errors))
                        break;
                    }
                    //                    completion(ResponseModel.init(code: 200, body: response.result.value as! NSDictionary))
                }
                break
            case .failure(let error):
                print(error)
                Toast(text: "Something went wrong. Please try again later").show()
                completion(ResponseModel.init(code: 0, body: [:], message: "Something went wrong. Please try again later"))
            }
        }
    }
    
    
    
    static var currentTask: URLSessionDataTask?
    
    func callButCancelPastRequest(api: String, parameters: [String: String], completion: @escaping (ResponseModel?) -> ()) {
        
        let urlString = AppConst.BASE_URL + api
        let safeURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if (Networking.currentTask != nil && Networking.currentTask?.state == .running){
            Networking.currentTask?.cancel()
        }
        
        let components = URLComponents(string: safeURL)
        guard let url = components?.url else { return }
        
        Networking.currentTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("LoqatePlaces Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("LoqatePlaces Error: No response from API")
                return
            }
            
            guard response.statusCode == 200 else {
                print("LoqatePlaces Error: Invalid status code \(response.statusCode) from API")
                return
            }
            
            let object: NSDictionary?
            do {
                object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
            } catch {
                object = nil
                print("LoqatePlaces Error")
                return
            }
            
            // Perform table updates on UI thread
            DispatchQueue.main.async {
                Networking.currentTask = nil
                completion(ResponseModel.init(code: 200, body: object!))
            }
        })
        
        Networking.currentTask?.resume()
    }
    
}



class NetworkRequestRetrier: RequestRetrier {
    
    // [Request url: Number of times retried]
    private var retriedRequests: [String: Int] = [:]
    
    internal func should(_ manager: SessionManager,
                         retry request: Request,
                         with error: Error,
                         completion: @escaping RequestRetryCompletion) {
        
        guard
            request.task?.response == nil,
            let url = request.request?.url?.absoluteString
        else {
            removeCachedUrlRequest(url: request.request?.url?.absoluteString)
            completion(false, 0.0) // don't retry
            return
        }
        
        guard let retryCount = retriedRequests[url] else {
            retriedRequests[url] = 1
            completion(true, 1.0) // retry after 1 second
            return
        }
        
        if retryCount <= 3 {
            retriedRequests[url] = retryCount + 1
            completion(true, 1.0) // retry after 1 second
        } else {
            removeCachedUrlRequest(url: url)
            completion(false, 0.0) // don't retry
        }
        
    }
    
    private func removeCachedUrlRequest(url: String?) {
        guard let url = url else {
            return
        }
        retriedRequests.removeValue(forKey: url)
    }
}



