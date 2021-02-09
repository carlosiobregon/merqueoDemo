//
//  MovieCellPresenter.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 8/02/21.
//

import Foundation
import UIKit

class MovieCellPresenter: IMovieCellViewToPresenter, IMovieCellInteractorToPresenter {
   
    //  MARK: - Atributes
    let movie: Movie
    weak var view: IMovieCellPresenterToView?
    var interactor: IMovieCellPresenterToInteractor?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    //  MARK: - IMovieCellViewToPresenter
    func fetchImage() {
        interactor?.fetchImage(movie: movie)
    }

    //  MARK: - IMovieCellInteractorToPresenter
    func imageFetchedSuccess(movieImage: MovieImage) {
        if movie.id == movieImage.id, let image = movieImage.image {
            view?.showImage(image: image)
        } else {
            view?.showImageError()
        }
    }
    
    func imageFetchFailed() {
        view?.showImageError()
    }
    
}
