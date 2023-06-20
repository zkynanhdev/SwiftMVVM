//
//  PostViewModel.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class PostViewModel{
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var posts: [PostModel] = []
    init() {
        self.state = .idle
    }
    
}

extension PostViewModel {
    
    var numberOfItems: Int {
        self.posts.count
    }
    
    func getInfo(index: Int) -> PostModel {
        return self.posts[index]
    }
    
    func loadData(id: Int){
        self.state = .loading
        PostServices().getPosts(id: id) {
            result in
            switch result{
            case let .success(posts):
                self.posts = posts
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}
