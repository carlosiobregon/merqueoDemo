//
//  ProxyImage.swift
//  Copa Airlines
//
//  Created by Fredy Mauricio Navarrete Molano on 12/13/18.
//  Copyright © 2018 Copa Airlines. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ProxyImage {
    static let shared = ProxyImage()
    
    func execute(path: String?,
                 responder: IRepositoryResponse,
                 serviceTag: Constants.ServiceTag,
                 idResource: String) {
        if let it = path {
            AF.request(it).responseImage(completionHandler: {
                response in
                self.processResponse(response: response, responder: responder, serviceTag: serviceTag, name: idResource)
            })
        } else {
            responder.onRetrievedData(response: nil, serviceTag: serviceTag, fromWeb: true)
        }
    }
    
    private func processResponse(response: AFDataResponse<Image>, responder: IRepositoryResponse, serviceTag: Constants.ServiceTag, name: String){
        switch response.response?.statusCode {
        case 200:
            let movieImage = MovieImage(id: name, image: response.value)
            responder.onRetrievedData(response: movieImage, serviceTag: serviceTag, fromWeb: true)
        default:
            responder.onFail(message: response.error, serviceTag: serviceTag, fromWeb: true)
        }
    }
}
