//
//  MovieDetailViewController.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 9/02/21.
//

import UIKit

class MovieDetailViewController: UIViewController, IMovieDetailPresenterToView {
    
    
    @IBOutlet weak var movieImage: UIImageView! {
        didSet {
            movieImage.contentMode = .scaleAspectFill
            movieImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var year: UILabel!
    
    
    
    var presenter: IMovieDetailViewToPresenter?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Detail"
        showProgressIndicator(view: self.view)
        presenter?.fetchMovieDetail()
        presenter?.fetchMovieImage()
    }
    
    func showMovieDetailFetchedSuccess(movieDetail: MovieDetailResponse) {
        summary.text = movieDetail.overview
        tagline.text = movieDetail.tagline
        average.text = "\(movieDetail.vote_average)"
        year.text = movieDetail.release_date
        self.title = movieDetail.original_title
        hideProgressIndicator(view: self.view)
    }
    
    func showMovieDetailFetchFailed() {
        summary.text = "---"
        tagline.text = "Nothing"
        average.text = "0,0"
        year.text = "00/00/0000"
        hideProgressIndicator(view: self.view)
    }
    
    func showMovieDetailImageFetchedSuccess(movieDetailImage: UIImage) {
        movieImage.image = movieDetailImage
    }
    
    func showMovieDetailImageFetchFailed() {
        movieImage.image = nil
    }


}
