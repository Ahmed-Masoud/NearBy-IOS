//
//  BaseAPI.swift
//  NearBy-IOS
//
//  Created by Ahmed masoud on 7/17/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Mappable>(target: T, responseClass: M.Type, completion:@escaping (Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        printRequest(target: target)
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                completion(.failure(NSError()))
                return
            }
            if statusCode == 200 {
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    completion(.failure(NSError()))
                    return
                }
                
                guard let obj = Mapper<M>().map(JSONObject: jsonResponse) else {
                    // ADD Custom Error
                    completion(.failure(NSError()))
                    return
                }
                
                completion(.success(obj))
            } else {
                // ADD custom error base on status code 404 / 401 /
                completion(.failure(NSError()))
            }
        }
    }
    
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    private func printRequest(target: T) {
        print("###")
        print("request called: \(target.baseURL)\(target.path)")
        print("http method: \(target.method)")
        if let headers = target.headers {
            print("headers: \(headers)")
        }
        print("parameters: \(target.task)")
        print("###")
    }
}

