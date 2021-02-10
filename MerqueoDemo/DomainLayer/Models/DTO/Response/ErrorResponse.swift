//
//  ErrorResponse.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int?
    let message: String
    let additionalDetails: String?
    let originalError: String?
    let pnrError: String?
}
