//
//  PopularMoviesProtocols.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation
import UIKit

protocol IPopularMoviesViewToPresenter: class {
    var view: IPopularMoviesPresenterToView? {get set}
    var interactor: IPopularMoviesPresenterToInteractor? {get set}
    var router: IPopularMoviesPresenterToRouter? {get set}
    var moviesNumber: Int {get}
    func fetchPopularMovies()
    func loadMorePopularMovies()
    func configureCell(_ cell: MovieCollectionViewCell, forItemAt: Int)
}

protocol IPopularMoviesPresenterToView: class {
    func showPopularMovies(didAddItemsAt indexes: IndexSet)
    func showError()
}

protocol IPopularMoviesPresenterToRouter: class {
    static func createModule()-> PopularMoviesViewController
}

protocol IPopularMoviesPresenterToInteractor: class {
    var presenter:IPopularMoviesInteractorToPresenter? {get set}
    func fetchPopularMovies()
}

protocol IPopularMoviesInteractorToPresenter: class {
    func moviesFetchedSuccess(newPopularMovies:[Movie])
    func moviesFetchFailed()
}
