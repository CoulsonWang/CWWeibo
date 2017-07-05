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
        return tool
    }()
}

// MARK:- 封装请求
extension CWNetworkTool {
    func request(_ requestType : RequestType, urlString : String, parameters : [String : Any], completion : @escaping (_ result : Any?, _ error : Error?) -> ()) {
        
        let successCallBack = { (task : URLSessionDataTask, result : Any) in
            completion(result, nil)
        }
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