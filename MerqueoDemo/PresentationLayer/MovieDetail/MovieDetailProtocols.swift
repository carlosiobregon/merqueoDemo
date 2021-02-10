//
//  MovieDetailProtocols.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import Foundation
import UIKit

protocol IMovieDetailViewToPresenter: class {
    var view: IMovieDetailPresenterToView? {get set}
    var interactor: IMovieDetailPresenterToInteractor? {get set}
    func fetchMovieDetail()
    func fetchMovieImage()
}

protocol IMovieDetailPresenterToView: UIViewController {
    func showMovieDetailFetchedSuccess(movieDetail: MovieDetailResponse)
    func showMovieDetailFetchFailed()
    func showMovieDetailImageFetchedSuccess(movieDetailImage: UIImage)
    func showMovieDetailImageFetchFailed()
}

protocol IMovieDetailPresenterToInteractor: class {
    var presenter:IMovieDetailInteractorToPresenter? {get set}
    func fetchMovieDetail(movieId: String)
    func fetchMovieImage(path: String)
}

protocol IMovieDetailInteractorToPresenter: class {
    func movieDetailFetchedSuccess(movieDetail: MovieDetailResponse)
    func movieDetailFetchFailed()
    func movieDetailImageFetchedSuccess(image: UIImage)
    func movieDetailImageFetchFailed()
}
