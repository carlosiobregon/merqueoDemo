//
//  MovieCellProtocols.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 8/02/21.
//

import Foundation
import UIKit

protocol IMovieCellViewToPresenter: class {
    var view: IMovieCellPresenterToView? {get set}
    var interactor: IMovieCellPresenterToInteractor? {get set}
    func fetchImage()
}

protocol IMovieCellPresenterToView: UICollectionViewCell {
    func showImage(image: UIImage)
    func showImageError()
}

protocol IMovieCellPresenterToInteractor: class {
    var presenter:IMovieCellInteractorToPresenter? {get set}
    func fetchImage(movie: Movie)
}

protocol IMovieCellInteractorToPresenter: class {
    func imageFetchedSuccess(movieImage: MovieImage)
    func imageFetchFailed()
}
