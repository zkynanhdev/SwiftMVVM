//
//  UserServices.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation
import Alamofire

final class UserServices {
    
    func getUsers(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        AF.request(ApiServices.Endpoint.userList.url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200 ..< 299).responseData {
                response in
                switch response.result {
                case .success(let data):
                        let decoder = JSONDecoder()
                        do {
                            let users = try decoder.decode([UserModel].self, from: data)
                            completion(.success(users))
                        } catch let error {
                            completion(.failure(error))
                        }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
