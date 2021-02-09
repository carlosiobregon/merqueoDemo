//
//  MovieCellRouter.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 8/02/21.
//

import Foundation
import UIKit

class MovieCellRouter {
    
    static func createModule(movie: Movie, view: MovieCollectionViewCell) {
        
        let presenter: IMovieCellViewToPresenter & IMovieCellInteractorToPresenter = MovieCellPresenter(movie: movie)
        let interactor: IMovieCellPresenterToInteractor = MovieCellInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
    }
}
