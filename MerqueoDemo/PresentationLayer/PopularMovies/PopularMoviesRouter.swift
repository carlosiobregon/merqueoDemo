//
//  Movie.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation
import UIKit

class PopularMoviesRouter: IPopularMoviesPresenterToRouter {
    
    static func createModule() -> PopularMoviesViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "MyViewController") as! PopularMoviesViewController
        
        let presenter: IPopularMoviesViewToPresenter & IPopularMoviesInteractorToPresenter = PopularMoviesPresenter()
        let interactor: IPopularMoviesPresenterToInteractor = PopularMoviesInteractor()
        let router:IPopularMoviesPresenterToRouter = PopularMoviesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
}
