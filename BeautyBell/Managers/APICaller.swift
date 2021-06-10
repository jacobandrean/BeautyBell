//
//  APICaller.swift
//  BeautyBell
//
//  Created by Jacob Andrean on 10/06/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func fetchArtisanList(completion: @escaping(Result<[Artisan], Error>) -> Void) {
        guard let url = URL(string: "https://604048b4f34cf600173c7cda.mockapi.io/api/v1/list-artisan") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let result = try JSONDecoder().decode([Artisan].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
