//
//  Constants.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation

struct Constants {
    enum ServiceTag{
        case
        FAIL,
        GET_POPULAR_MOVIES,
        GET_MOVIE_IMAGE
    }
    enum HTTPMethod{
        case
        GET,
        POST
    }
    
    struct EndPoints{
        static let BASE_URL = "http://api.themoviedb.org/3"
        static let BASE_URL_RESOURCES = "http://image.tmdb.org/t/p/w500";
        static let PATH_POPULAR_MOVIES = "/movie/popular?"
    }
    
    struct HTTPStatusCode {
        static let OK = 200
        static let INTERNAL_SERVER_ERROR = 500
        static let UNAUTHORIZED = 401
        static let INVALID_REQUEST = 404
    }
    
    static let API_KEY = "2ea5adc47456e674399d947d032e74e5";
    static let PROGRESS_INDICATOR_VIEW_TAG:Int = 10
}
