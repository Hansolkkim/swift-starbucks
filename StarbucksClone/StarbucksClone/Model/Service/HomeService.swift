//
//  HomeService.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeComponentsDataFetchable {
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<HomeComponentsDTO, NetworkError>) -> Void)
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<BeverageImageDTO, NetworkError>) -> Void)
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<BeverageInfoDTO, NetworkError>) -> Void)
    func fetchImage(of url: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

struct HomeService: HomeComponentsDataFetchable {
    func fetchImage(of url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(.transferError))
        }
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return completion(.failure(.noImageError))
            }
            completion(.success(data))
        }.resume()
    }
    
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
                print("decode error \(String(data: data, encoding: .utf8))")
                return completion(.failure(.unDecodedError))
            }
            
            completion(.success(decodedData))
        }.resume()
    }
    
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<BeverageImageDTO, NetworkError>) -> Void) {
        guard let request = makeRequest(of: kind) else { return }
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
            
            guard let decodedImageData = try? JSONDecoder().decode(BeverageImageDTO.self, from: data) else {
                print("decode error \(String(data: data, encoding: .utf8))")
                return completion(.failure(.unDecodedError))
            }
            completion(.success(decodedImageData))
        }.resume() 
    }
    
    func fetchData(of kind: HomeAPI, completion: @escaping (Result<BeverageInfoDTO, NetworkError>) -> Void) {
        guard let request = makeRequest(of: kind) else { return }
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
            
            guard let decodedInfoData = try? JSONDecoder().decode(BeverageInfoDTO.self, from: data) else {
                print("decode error \(String(data: data, encoding: .utf8))")
                return completion(.failure(.unDecodedError))
            }
            completion(.success(decodedInfoData))
        }.resume() // title only
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
