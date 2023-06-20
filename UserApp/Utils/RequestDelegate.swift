//
//  RequestDelegate.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

protocol RequestDelegate: AnyObject {
    func didUpdate(with state: ViewState)
}

enum ViewState {
    case idle
    case loading
    case success
    case error(Error)
}
