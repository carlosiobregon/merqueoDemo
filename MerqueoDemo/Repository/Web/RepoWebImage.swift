//
//  RepoWebImage.swift
//  Copa Airlines
//
//  Created by Fredy Mauricio Navarrete Molano on 12/14/18.
//  Copyright © 2018 Copa Airlines. All rights reserved.
//

import Foundation

class RepoWebImage {
    
    static func getImage(iReponder: IRepositoryResponse, movie: Movie) {
        
        let resourcePath = "\(Constants.EndPoints.BASE_URL_RESOURCES)\(movie.imageUrl ?? String())"
        ProxyImage.shared.execute(
            path: resourcePath,
            responder: iReponder,
            serviceTag: Constants.ServiceTag.GET_MOVIE_IMAGE,
            idResource: movie.id
        )
    }
    
}
