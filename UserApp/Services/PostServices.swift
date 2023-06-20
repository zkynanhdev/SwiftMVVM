//
//  PostServices.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation
import Alamofire

final class PostServices {
    
    func getPosts(id: Int, completion: @escaping (Result<[PostModel], Error>) -> Void) { AF.request(ApiServices.Endpoint.postList(id).url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200 ..< 299).responseData {
                response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                        do {
                            let posts = try decoder.decode([PostModel].self, from: data)
                            completion(.success(posts))
                        } catch let error {
                            completion(.failure(error))
                        }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
