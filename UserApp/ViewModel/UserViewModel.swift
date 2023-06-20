//
//  UserViewModel.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class UserViewModel{
    
    weak var delegate: RequestDelegate?
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    
    private var users: [UserModel] = []
    init() {
        self.state = .idle
    }
    
}

extension UserViewModel {
    
    var numberOfItems: Int {
        self.users.count
    }
    
    func getInfo(index: Int) -> UserModel {
        return self.users[index]
    }
    
    func loadData(){
        self.state = .loading
        UserServices().getUsers() {
            result in
            switch result{
            case let .success(users):
                self.users = users
                self.state = .success
            case let .failure(error):
                self.state = .error(error)
            }
        }
    }
}

