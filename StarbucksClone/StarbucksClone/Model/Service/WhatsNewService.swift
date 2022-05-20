//
//  WhatsNewService.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import Foundation

protocol WhatsNewEventDataFetchable {
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<[WhatsNewEventDTO], NetworkError>) -> Void)
    func fetchImage(of url: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

struct WhatsNewService: WhatsNewEventDataFetchable {

    private let urlSession = URLSession.shared

    func fetchData(of kind: HomeAPI, completion: @escaping (Result<[WhatsNewEventDTO], NetworkError>) -> Void) {
        guard let url = URL(string: kind.baseURL + kind.path) else { return }

        urlSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return completion(.failure(.transferError))
            }

            guard let data = data else {
                return completion(.failure(.noData))
            }

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.noResponse))
            }
            let statusCode = response.statusCode

            guard 200..<300 ~= statusCode else {
                return completion(.failure(.serverError(statusCode: statusCode)))
            }

            guard let decodedData = decodeData(of: data) else {
                return completion(.failure(.unDecodedError))
            }

            completion(.success(decodedData))
        }.resume()
    }

    private func decodeData(of data: Data) -> [WhatsNewEventDTO]? {
        return try? JSONDecoder().decode([WhatsNewEventDTO].self, from: data).sorted(by: {
            $0.startAt > $1.startAt
        })
    }

    func fetchImage(of url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.transferError))
        }

        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completion(.failure(.noImageError))
            }
            completion(.success(data))
        }.resume()
    }
}
