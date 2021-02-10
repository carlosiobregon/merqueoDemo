//
//  DetailMovieResponde.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import Foundation

struct MovieDetailResponse: Codable {
    let original_title: String
    let overview: String?
    let backdrop_path: String?
    let vote_average: Double
    let release_date: String
    let tagline: String
}
