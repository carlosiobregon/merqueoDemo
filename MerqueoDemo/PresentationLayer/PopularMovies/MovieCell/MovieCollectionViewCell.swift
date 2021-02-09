//
//  MovieCollectionViewCell.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 7/02/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, IMovieCellPresenterToView {
    
    
    //  MARK: - UI Elements
    @IBOutlet weak var postCard: UIImageView!{
        didSet {
            postCard.contentMode = .scaleAspectFill
            postCard.clipsToBounds = true
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //  MARK: - Atributes
    var presenter: IMovieCellViewToPresenter?
    
    
    //  MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postCard.image = nil
    }
    
    func setupCell() {
        activityIndicator.startAnimating()
        presenter?.fetchImage()
    }
 
    
    //  MARK: - IMovieCellPresenterToView
    func showImage(image: UIImage) {
        DispatchQueue.main.async {
            self.postCard.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    func showImageError() {
        self.activityIndicator.stopAnimating()
    }

}
