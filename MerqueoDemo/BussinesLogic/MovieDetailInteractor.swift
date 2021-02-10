//
//  MovieDetailInteractor.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import Foundation
import UIKit

class MovieDetailInteractor: IMovieDetailPresenterToInteractor {
    
    var presenter: IMovieDetailInteractorToPresenter?
    var id: String = ""

    func fetchMovieDetail(movieId: String) {
        RepoWebMovies.getMovieDetail(iResponder: self, id: movieId)
        self.id = movieId
    }
    
    func fetchMovieImage(path: String) {
        RepoWebImage.getImage(iReponder: self, movie: Movie(id: id, imageUrl: path))
    }
    
}

// MARK: - IRepositoryResponse
extension MovieDetailInteractor: IRepositoryResponse {
    func onRetrievedData(response: Any?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_MOVIE_DETAIL:
                guard let detail = response as? MovieDetailResponse else {
                    presenter?.movieDetailImageFetchFailed()
                    return
                }
                presenter?.movieDetailFetchedSuccess(movieDetail: detail)
            case .GET_MOVIE_IMAGE:
                guard let it = response as? MovieImage, let image = it.image else {
                    presenter?.movieDetailImageFetchFailed()
                    return
                }
                presenter?.movieDetailImageFetchedSuccess(image: image)
            default:break
            }
        }
    }
    
    func onFail(message: Error?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_MOVIE_DETAIL:
                presenter?.movieDetailFetchFailed()
            case .GET_MOVIE_IMAGE:
                presenter?.movieDetailImageFetchFailed()
            default: break
                
            }
        }
    }
}
    

