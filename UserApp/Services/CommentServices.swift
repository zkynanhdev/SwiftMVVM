//
//  CommentServices.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation
import Alamofire

final class CommentServices {
    
    func getComments(id: Int, completion: @escaping (Result<[CommentModel], Error>) -> Void) {
        AF.request(ApiServices.Endpoint.commentList(id).url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200 ..< 299).responseData {
                response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                        do {
                            let comments = try decoder.decode([CommentModel].self, from: data)
                            completion(.success(comments))
                        } catch let error {
                            completion(.failure(error))
                        }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
