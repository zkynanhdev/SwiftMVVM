//
//  AlbumViewModel.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class AlbumViewModel{
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var albums: [AlbumModel] = []
    init() {
        self.state = .idle
    }
    
}

extension AlbumViewModel {
    
    var numberOfItems: Int {
        self.albums.count
    }
    
    func getInfo(index: Int) -> AlbumModel {
        return self.albums[index]
    }
    
    func loadData(userId: Int){
        self.state = .loading
        AlbumServices().getAlbums(userId: userId) {
            result in
            switch result{
            case let .success(albums):
                self.albums = albums
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}
