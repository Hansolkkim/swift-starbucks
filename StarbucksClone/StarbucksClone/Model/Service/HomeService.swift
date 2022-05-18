//
//  HomeService.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeComponentsDataFetchable {
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<HomeComponentsDTO, NetworkError>) -> Void)
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<(BeverageImageDTO?, BeverageInfoDTO?), NetworkError>) -> Void)
}

struct HomeService: HomeComponentsDataFetchable {
    private let urlSession = URLSession.shared
    
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<HomeComponentsDTO, NetworkError>) -> Void) {
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
    
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<(BeverageImageDTO?, BeverageInfoDTO?), NetworkError>) -> Void) {
        guard let request = makeRequest(of: kind) else {return}
        urlSession.dataTask(with: request) { (data, response, error) in
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

            if let decodedImageData = try? JSONDecoder().decode(BeverageImageDTO.self, from: data) {
                return completion(.success((decodedImageData, nil)))
            } else if let decodedInfoData = try? JSONDecoder().decode(BeverageInfoDTO.self, from: data) {
                return completion(.success((nil, decodedInfoData)))
            } else {
                return completion(.failure(.unDecodedError))
            }
        }.resume()
    }
    
    private func decodeData(of data: Data) -> HomeComponentsDTO? {
        return try? JSONDecoder().decode(HomeComponentsDTO.self, from: data)
    }
    
    private func makeRequest(of kind: HomeAPI) -> URLRequest? {
        guard let url = URL(string: kind.baseURL + kind.path) else { return nil }
        
        var request = URLRequest(url: url)

        request.httpMethod = kind.method
        request.setValue(kind.headerContentType,
                         forHTTPHeaderField: "Content-type")

        request.httpBody = makeBody(kind: kind)

        return request
    }

    private func makeBody(kind: HomeAPI) -> Data? {
        if let parameter = kind.parameter {
            let formDataString = parameter.reduce(into:"") {
                $0 = $0 + "\($1.key)=\($1.value)&"
            }.dropLast()

            return formDataString.data(using: .utf8)
        }

        return nil
    }
}
