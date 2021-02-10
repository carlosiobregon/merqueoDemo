//
//  MovieCellInteractor.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 8/02/21.
//

import Foundation
import UIKit

class MovieCellInteractor: IMovieCellPresenterToInteractor {
    var presenter: IMovieCellInteractorToPresenter?
    
    func fetchImage(movie: Movie) {
        if let image = ImagesCache.shared.get(id: movie.id as NSString) {
            presenter?.imageFetchedSuccess(movieImage: MovieImage(id: movie.id, image: image))
        } else {
            RepoWebImage.getImage(iReponder: self, movie: movie)
        }
    }
    
}

// MARK: - IRepositoryResponse
extension MovieCellInteractor: IRepositoryResponse {
    func onRetrievedData(response: Any?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_MOVIE_IMAGE:
                guard let movieImage = response as? MovieImage,
                      let image = movieImage.image else {
                    presenter?.imageFetchFailed()
                    return
                }
                ImagesCache.shared.set(id: movieImage.id as NSString, image: image)
                presenter?.imageFetchedSuccess(movieImage: movieImage)
                
                
                
            default:break
            }
        }
    }
    
    func onFail(message: Error?, serviceTag: Constants.ServiceTag, fromWeb: Bool) {
        if fromWeb {
            switch serviceTag {
            case .GET_MOVIE_IMAGE:
                presenter?.imageFetchFailed()
            default: break
                
            }
        }
    }
}
    

