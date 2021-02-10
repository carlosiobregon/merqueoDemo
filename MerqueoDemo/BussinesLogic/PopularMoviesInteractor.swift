//
//  PopularMoviesInteractor.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import Foundation
import Alamofire
import RxSwift


class PopularMoviesInteractor: IPopularMoviesPresenterToInteractor {
    
    var presenter: IPopularMoviesInteractorToPresenter?
    var disposeBag: DisposeBag? = DisposeBag()
    var atPage: Int = .zero
    var atLastPage = false
    let preferredLocale = Locale.current
    
    func fetchPopularMovies() {
        atPage += 1
        let params = ParamsToPopularMovies(api_key: Constants.API_KEY,
                                           language: preferredLocale.languageCode,
                                           page: "\(atPage)",
                                           region: preferredLocale.regionCode)
        RepoWebMovies.getPopularMovies(iResponder: self, params: params)
    }
 
}

// MARK: - IRepositoryResponse
extension PopularMoviesInteractor: IRepositoryResponse {
    func onRetrievedData(response: Any?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_POPULAR_MOVIES:
                guard let moviesResponse = response as? PopularMoviesResponse else { return }           
                if moviesResponse.results.count == .zero {
                    self.atLastPage = true
                }
                self.presenter?.moviesFetchedSuccess(newPopularMovies: moviesResponse.toMovies())
            default:
                break
            }
        } else {
            switch serviceTag {
            case .GET_POPULAR_MOVIES: break
            default: break
                
            }
        }
    }
    
    func onFail(message: Error?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_POPULAR_MOVIES:
                self.presenter?.moviesFetchFailed()
            default: break
                
            }
        } else {
            switch serviceTag {
            case .GET_POPULAR_MOVIES:
                return
            default: break
                
            }
        }
    }
    
    
}

