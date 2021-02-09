//
//  ErrorResponseString.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

struct ErrorResponseString: Codable {
    let code: String?
    let message: String
    
    func toErrorResponse() -> ErrorResponse {
        let errorResponse: ErrorResponse
        if let currentCode = code {
            errorResponse = ErrorResponse(code: Int(currentCode), message: message, additionalDetails: nil, originalError: nil, pnrError: nil)
        } else {
            errorResponse = ErrorResponse(code: nil, message: message, additionalDetails: nil, originalError: nil, pnrError: nil)
        }
        return errorResponse
    }
}
