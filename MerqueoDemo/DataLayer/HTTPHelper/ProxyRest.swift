//
//  ProxyRest.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation
import Alamofire

class ProxyRest <T: Decodable> {
    open class func execute <U: Encodable>(path: String,
                                           methodType: Constants.HTTPMethod,
                                           headers: [String : String]? = nil,
                                           responder: IRepositoryResponse,
                                           serviceTag: Constants.ServiceTag,
                                           body: U?,
                                           baseURL: String? = nil,
                                           isArrayError: Bool = false)
    {
        let url = "\(baseURL ?? Constants.EndPoints.BASE_URL)\(path)"
        var method: HTTPMethod
        var bodyPameter: [String : Any]? = nil
        
        switch methodType {
        case .GET:
            method = .get
        case .POST:
            method = .post
            bodyPameter = JSONParser.object2Dictionary(object: body)
        }
        
        do {
            let queue = DispatchQueue.global(qos: .utility)
            let httpHeaders: HTTPHeaders?
            if let it = headers {
                httpHeaders = HTTPHeaders(it)
            } else {
                httpHeaders = nil
            }
            
            try AF.request(url.asURL(), method: method, parameters: bodyPameter, encoding: JSONEncoding.default, headers: httpHeaders).responseJSON(queue: queue, options: .allowFragments, completionHandler: {
                (response: AFDataResponse<Any>) in
                DispatchQueue.main.async {
                    self.processResponse(response: response, responder: responder, serviceTag: serviceTag, isArrayError: isArrayError, closure: { isSuccess in
                            if isSuccess {
                                ProxyRest.execute(path: path, methodType: methodType, headers: nil, responder: responder, serviceTag: serviceTag, body: body, baseURL: baseURL, isArrayError: isArrayError)}
                            else {
                                responder.onFail(message: response as? Error, serviceTag: serviceTag, fromWeb: true)
                            }
                        }
                    )
                }
            })
        } catch {
            ConnectionStatus.shared.canConnectToServer = false
            DispatchQueue.main.async {
                responder.onFail(message: error, serviceTag: serviceTag, fromWeb: true)
            }
        }
    }
    
    static func processResponse(response: AFDataResponse<Any>, responder: IRepositoryResponse, serviceTag: Constants.ServiceTag, isArrayError: Bool, closure: @escaping (Bool) -> Void){
        switch response.response?.statusCode {
        case Constants.HTTPStatusCode.OK:
            ConnectionStatus.shared.canConnectToServer = true
            if let it = response.data {
                let responseObject = try? JSONDecoder().decode(T.self, from: it)
                responder.onRetrievedData(response: responseObject, serviceTag: serviceTag, fromWeb: true)
            } else{
                responder.onRetrievedData(response: nil, serviceTag: serviceTag, fromWeb: true)
            }
        case Constants.HTTPStatusCode.INTERNAL_SERVER_ERROR, Constants.HTTPStatusCode.INVALID_REQUEST:
            ConnectionStatus.shared.canConnectToServer = true
            responder.onFail(message: response.error, serviceTag: serviceTag, fromWeb: true)
            
        case Constants.HTTPStatusCode.UNAUTHORIZED:
            responder.onFail(message: response.error, serviceTag: serviceTag, fromWeb: true)
        default:
            responder.onFail(message: response.error, serviceTag: serviceTag, fromWeb: true)
        }
    }
    
}


