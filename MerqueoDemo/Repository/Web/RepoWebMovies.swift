//
//  IRepositoryResponse.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

class RepoWebMovies {
    
    static func getPopularMovies(iResponder: IRepositoryResponse, page: Int) {
        
        let params = ParamsToPopularMovies(api_key: Constants.API_KEY,
                                           language: Locale.current.languageCode,
                                           page: "\(page)",
                                           region: Locale.current.regionCode)
        
        let queryParams = JSONParser.object2QueryParams(object: params) ?? String()
        let path = "\(Constants.EndPoints.PATH_POPULAR_MOVIES)\(queryParams)"
        
        ProxyRest<PopularMoviesResponse>.execute(
            path: path,
            methodType: Constants.HTTPMethod.GET,
            responder: iResponder,
            serviceTag: Constants.ServiceTag.GET_POPULAR_MOVIES,
            body: NilBody()
        )
        
    }
    
    static func getMovieDetail(iResponder: IRepositoryResponse, id: String) {
        
        let params = ParamsToPopularMovies(api_key: Constants.API_KEY,
                                           language: Locale.current.languageCode,
                                           page: nil,
                                           region: Locale.current.regionCode)
        let queryParams = JSONParser.object2QueryParams(object: params) ?? String()
        let path = "\(Constants.EndPoints.PATH_MOVIE_DETAIL)\(id)?\(queryParams)"
        
        ProxyRest<MovieDetailResponse>.execute(
            path: path,
            methodType: Constants.HTTPMethod.GET,
            responder: iResponder,
            serviceTag: Constants.ServiceTag.GET_MOVIE_DETAIL,
            body: NilBody()
        )
        
    }
    
}

