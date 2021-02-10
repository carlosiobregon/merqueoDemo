//
//  PopularMoviesPresenter.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation
import UIKit

class PopularMoviesPresenter: IPopularMoviesViewToPresenter, IPopularMoviesInteractorToPresenter {
        
    //  MARK: - Atributes
    var popularMovies = [Movie]()
    var view: IPopularMoviesPresenterToView?
    var interactor: IPopularMoviesPresenterToInteractor?
    var router: IPopularMoviesPresenterToRouter?
    var moviesNumber: Int {
        get {
            popularMovies.count
        }
    }
    
    //  MARK: - IPopularMoviesViewToPresenter
    func fetchPopularMovies() {
        interactor?.fetchPopularMovies()
    }
    
    func configureCell(_ cell: MovieCollectionViewCell, forItemAt: Int) {
        let summary = popularMovies[forItemAt]
        MovieCellRouter.createModule(movie: summary, view: cell)
        cell.setupCell()
    }
    
    func loadMorePopularMovies() {
        interactor?.fetchPopularMovies()
    }
    
    func showMovieDetail(at index: Int, view: MovieDetailViewController) {
        let movie = popularMovies[index]
        router?.pushToMovieScreen(idMovie: movie.id, view: view)
    }
    
    //  MARK: - IPopularMoviesInteractorToPresenter
    func moviesFetchedSuccess(newPopularMovies: [Movie]) {
        DispatchQueue.main.async {
            guard let view = self.view else {
                return
            }

            let currentCount = self.popularMovies.count
            let newStartIndex = currentCount
            let newLimit = currentCount + newPopularMovies.count
            let addedItems = IndexSet(integersIn: newStartIndex..<newLimit)
            self.popularMovies.append(contentsOf: newPopularMovies)
            view.showPopularMovies(didAddItemsAt: addedItems)
        }
    }
    
    func moviesFetchFailed() {
        view?.showError()
    }
    
}
