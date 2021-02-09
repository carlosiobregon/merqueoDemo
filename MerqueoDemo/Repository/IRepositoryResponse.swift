//
//  IRepositoryResponse.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

protocol IRepositoryResponse {
    func onRetrievedData(response: Any?, serviceTag: Constants.ServiceTag, fromWeb: Bool)
    func onFail(message: Error?, serviceTag: Constants.ServiceTag, fromWeb: Bool)
}

