//
//  MovieDetailPresenter.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import Foundation
import UIKit

class MovieDetailPresenter: IMovieDetailInteractorToPresenter, IMovieDetailViewToPresenter {
    
    
    let movieId: String
    weak var view: IMovieDetailPresenterToView?
    var interactor: IMovieDetailPresenterToInteractor?
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    func fetchMovieDetail() {
        interactor?.fetchMovieDetail(movieId: movieId)
    }
    
    func fetchMovieImage() {
        interactor?.fetchMovieDetail(movieId: movieId)
    }
    
    func movieDetailFetchedSuccess(movieDetail: MovieDetailResponse) {
        interactor?.fetchMovieImage(path: movieDetail.backdrop_path ?? String())
        view?.showMovieDetailFetchedSuccess(movieDetail: movieDetail)
    }
    
    func movieDetailFetchFailed() {
        view?.showMovieDetailFetchFailed()
    }
    
    func movieDetailImageFetchedSuccess(image: UIImage) {
        view?.showMovieDetailImageFetchedSuccess(movieDetailImage: image)
    }
    
    func movieDetailImageFetchFailed() {
        view?.showMovieDetailImageFetchFailed()
    }
    
}

