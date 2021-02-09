//
//  ParamsToPopularMovies.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import Foundation

struct ParamsToPopularMovies: Encodable {
    let api_key: String
    let language: String?
    let page: String?
    let region: String?
}
