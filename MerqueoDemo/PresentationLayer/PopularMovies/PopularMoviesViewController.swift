//
//  PopularMoviesViewController.swift
//  MerqueoDemo
//
//  Created by Carlos Obregón on 5/02/21.
//

import UIKit

class PopularMoviesViewController: UIViewController {

//  MARK: - UI Elements
    @IBOutlet weak var uiCollectionView: UICollectionView! {
        didSet {
            uiCollectionView.frame = .zero
            uiCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        }
    }
    
//  MARK: - Atributes
    let insetSection = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    let minimumInteritemSpacing = CGFloat(1)
    let minimumLineSpacing = CGFloat(1)
    let rows = CGFloat(3)
    let extraHeight = CGFloat(30)
    let extraSpace = CGFloat(2)
    var presenter:IPopularMoviesViewToPresenter?
    
//  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movies"
        presenter?.fetchPopularMovies()
        showProgressIndicator(view: self.view)
        
        let nib = UINib(nibName: MovieCollectionViewCell.defaultReuseIdentifier, bundle: nil)
        uiCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier)
        
        uiCollectionView.dataSource = self
        uiCollectionView.delegate = self
    }
    
    
    //    MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popularmovies_2_moviedetails",
           let detailView = segue.destination as? MovieDetailViewController,
           let index = sender as? Int {
            presenter?.showMovieDetail(at: index, view: detailView)
        }
    }

}

//  MARK: -
extension PopularMoviesViewController: IPopularMoviesPresenterToView {
    
    func showPopularMovies(didAddItemsAt indexes: IndexSet) {
        let indexPaths = indexes.map {
            IndexPath(row: $0, section: .zero)
        }
        uiCollectionView.insertItems(at: indexPaths)
        hideProgressIndicator(view: self.view)
    }
    
    func showError() {
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Notice", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//  MARK: -
extension PopularMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = self.presenter else {
            return .zero
        }
        return presenter.moviesNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultReuseIdentifier, for: indexPath)
        
        guard
            let cell = collectionCell as? MovieCollectionViewCell
        else {
            return collectionCell
        }
        
        if let presenter = self.presenter {
            presenter.configureCell(cell, forItemAt: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        uiCollectionView.deselectItem(at: indexPath, animated: true)
        performSegue(withIdentifier: "popularmovies_2_moviedetails", sender: indexPath.row)
    }
}

//  MARK: -
extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.width/rows - extraSpace),
            height: (view.frame.width/rows + extraHeight)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetSection
    }
    
}

//  MARK: -
extension PopularMoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == uiCollectionView {
            let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
            if bottomEdge >= scrollView.contentSize.height {
                presenter?.loadMorePopularMovies()
            }
        }
    }
}

