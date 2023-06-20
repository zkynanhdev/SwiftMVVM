//
//  AlbumDetail.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/12/23.
//

import UIKit
import Alamofire

class AlbumDetail: AppController {
 
    private let viewModel = AlbumDetailViewModel()
    var albumId: Int? = nil

    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
      left: 10.0,
        bottom: 20.0,
      right: 10.0)

    @IBOutlet weak var collectionVC: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loadData(albumId: self.albumId ?? -1)
        
        let nib = UINib(nibName: "AlbumDetailCell", bundle: .main)
        
        collectionVC.register(nib, forCellWithReuseIdentifier: "cell")
        collectionVC.delegate = self
        collectionVC.dataSource = self
    }
}

extension AlbumDetail: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumDetailCell
        
        cell.setUpCell(album: viewModel.getInfo(index: indexPath.row))
        
        return cell
    }
    
}

extension AlbumDetail: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = view.frame.width - 40
        let widthPerItem = availableWidth / 3
            return CGSize(width: widthPerItem, height: widthPerItem + 20)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
          return sectionInsets.left
      }

}

extension AlbumDetail: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else { return }
            switch state {
            case .success:
                self.collectionVC.reloadData()
                self.stopLoading()
            case .idle:
                break
            case .loading:
                self.startLoading()
            case .error(let error):
                self.stopLoading()
                print(error)
            }
        }
    }
}


