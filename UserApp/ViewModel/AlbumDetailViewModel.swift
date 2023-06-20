//
//  AlbumDetailViewModel.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class AlbumDetailViewModel{
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var albumDetails: [AlbumDetailModel] = []
    
    init() {
        self.state = .idle
    }
    
}

extension AlbumDetailViewModel {
    
    var numberOfItems: Int {
        self.albumDetails.count
    }
    
    func getInfo(index: Int) -> AlbumDetailModel {
        return self.albumDetails[index]
    }
    
    func loadData(albumId: Int){
        self.state = .loading
        AlbumServices().getAlbumsDetail(albumId: albumId) {
            result in
            switch result{
            case let .success(albumDetails):
                self.albumDetails = albumDetails
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}
