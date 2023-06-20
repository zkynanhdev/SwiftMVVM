//
//  CommentViewModel.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class CommentViewModel{
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var comments: [CommentModel] = []
    init() {
        self.state = .idle
    }
    
}

extension CommentViewModel {
    
    var numberOfItems: Int {
        self.comments.count
    }
    
    func getInfo(index: Int) -> CommentModel {
        return self.comments[index]
    }
    
    func loadData(id: Int){
        self.state = .loading
        CommentServices().getComments(id: id) {
            result in
            switch result{
            case let .success(comments):
                self.comments = comments
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}
