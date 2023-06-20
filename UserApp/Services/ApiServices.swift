//
//  ApiServices.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation

final class ApiServices {
    
    private enum ApiUrl {
        case base
        
        var baseURL: String {
            switch self {
                case .base: return "https://jsonplaceholder.typicode.com"
            }
        }
    }
    
    enum Endpoint {
        case userList
        case postList(Int)
        case albumList(Int)
        case albumDetailList(Int)
        case commentList(Int)
        
        var url: String {
            switch self {
            case .userList: return "\(ApiUrl.base.baseURL)/users"
            case let .postList(userId): return "\(ApiUrl.base.baseURL)/posts?userId=\(userId)"
            case let .albumList(userId): return "\(ApiUrl.base.baseURL)/albums?userId=\(userId)"
            case let .albumDetailList(albumId): return "\(ApiUrl.base.baseURL)/photos?albumId=\(albumId)"
            case let .commentList(postId): return "\(ApiUrl.base.baseURL)/comments?postId=\(postId)"
            }
        }
    }
}
