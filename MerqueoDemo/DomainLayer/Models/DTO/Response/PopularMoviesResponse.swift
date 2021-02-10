//
//  PopularMoviesResponse.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

struct PopularMoviesResponse: Codable {
    let page: Int
    let results: [MovieResponse]
    let total_results: Int
    let total_pages: Int
}

extension PopularMoviesResponse {
    
    func toMovies() -> [Movie] {
        let movies = results.map{
            Movie(id: "\($0.id)", imageUrl: $0.poster_path)
        }
        return movies
    }
    
}
