//
//  AlbumServices.swift
//  UserApp
//
//  Created by AnhPhamPC on 6/20/23.
//

import Foundation
import Alamofire

final class AlbumServices {
    
    func getAlbums(userId: Int,completion: @escaping (Result<[AlbumModel], Error>) -> Void) {
        AF.request(ApiServices.Endpoint.albumList(userId).url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200 ..< 299).responseData {
                response in
                switch response.result {
                case .success(let data):
                        let decoder = JSONDecoder()
                        do {
                            let albums = try decoder.decode([AlbumModel].self, from: data)
                            completion(.success(albums))
                        } catch let error {
                            completion(.failure(error))
                        }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getAlbumsDetail(albumId: Int, completion: @escaping (Result<[AlbumDetailModel], Error>) -> Void) {
        AF.request(ApiServices.Endpoint.albumDetailList(albumId).url,method: .get, encoding: JSONEncoding.default)
            .validate(statusCode: 200 ..< 299).responseData {
                response in
                switch response.result {
                case .success(let data):
                        let decoder = JSONDecoder()
                        do {
                            let albumDetails = try decoder.decode([AlbumDetailModel].self, from: data)
                            completion(.success(albumDetails))
                        } catch let error {
                            completion(.failure(error))
                        }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
