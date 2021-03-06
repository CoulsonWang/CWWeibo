//
//  网络请求工具类
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import AFNetworking

//枚举请求类型
enum RequestType : String {
    case get = "get"
    case post = "post"
}

class CWNetworkTool: AFHTTPSessionManager {
    /// 单例
    static let sharedInstance : CWNetworkTool = {
        let tool : CWNetworkTool = CWNetworkTool()
        //增加允许的解析类型
        tool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tool
    }()
}

// MARK:- 封装请求
extension CWNetworkTool {
    func request(_ requestType : RequestType, urlString : String, parameters : [String : Any], completion : @escaping (Any?, Error?) -> ()) {
        //成功回调
        let successCallBack = { (task : URLSessionDataTask, result : Any) in
            completion(result, nil)
        }
        //失败回调
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) in
            completion(nil, error)
        }

        if requestType == .get {
            get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}

// MARK:- 封装AccessToken请求
extension CWNetworkTool {
    func loadAccessToken(code : String, completion : @escaping (_ result : [String : Any]?, _ error : Error?)->()) -> Void {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id" : app_key, "client_secret" : app_secret, "grant_type" : grant_type, "code" : code, "redirect_uri" : redirect_uri]
        
        request(.post, urlString: urlString, parameters: parameters) { (result, error) in
            completion(result as? [String : Any], error)
        }
        
    }
}

// MARK:- 请求用户信息
extension CWNetworkTool {
    func loadUserInfo(access_token : String, uid : String, completion : @escaping (_ result : [String : Any]?, _ error : Error?)->()) -> Void {
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token" : access_token, "uid" : uid]
        
        request(.get, urlString: urlString, parameters: parameters) { (result, error) in
            completion(result as? [String : Any], error)
        }
    }
}

// MARK:- 请求主页数据
extension CWNetworkTool {
    func loadStatusesData(since_id : Int , max_id : Int, completion : @escaping (_ result : [[String : Any]]?, _ error : Error?)->()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let parameters = ["access_token" : (WBUserAccountViewModel.sharedInstance.account?.access_token)!, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        
        request(.get, urlString: urlString, parameters: parameters) { (result, error) in
            
            guard let resultDict = result as? [String : Any] else {
               completion(nil, error)
                return
            }
            completion(resultDict["statuses"] as? [[String : Any]], error)
        }
        
    }
}

// MARK:- 发布微博
extension CWNetworkTool {
    func postStatus(statusText : String, isSuccess : (_ isSuccess : Bool) -> ()) -> Void {
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        let parameters = ["access_token": (WBUserAccountViewModel.sharedInstance.account?.access_token)!, "status": statusText]
        
        request(.post, urlString: urlString, parameters: parameters) { (result, error) in
        }
    }
}
