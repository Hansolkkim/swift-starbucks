//
//  EventService.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/12.
//

import Foundation

protocol EventDataFetchable{
    func fetchData(of kind: CodeSquadStarbuckst, completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void)
}

struct EventService: EventDataFetchable {
    private let urlSession = URLSession.shared

    func fetchData(of kind: CodeSquadStarbuckst, completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        guard let url = kind.url else {return}
        
        urlSession.dataTask(with: url) { data, response, error in
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

    private func decodeData(of data: Data) -> StarbuckstDTO? {
        return try? JSONDecoder().decode(StarbuckstDTO.self, from: data)
    }
}

enum NetworkError: Error {
    case transferError
    case noData
    case noResponse
    case serverError(statusCode: Int)
    case unDecodedError
}
