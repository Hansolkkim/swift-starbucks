//
//  HomeRepository.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeComponentsGettable {
    func getHomeComponentsData(completion: @escaping (Result<HomeComponentsDTO, NetworkError>) -> Void)
    func getHomeBeveragesData(productCD: String, completion: @escaping (Result<(BeverageImageDTO?, BeverageInfoDTO?), NetworkError>) -> Void)
}

struct HomeRepository: HomeComponentsGettable {
    let homeService: HomeComponentsDataFetchable
    
    init(homeService: HomeComponentsDataFetchable) {
        self.homeService = homeService
    }

    func getHomeComponentsData(completion: @escaping (Result<HomeComponentsDTO, NetworkError>) -> Void) {
        homeService.fetchData(of: .fetchHomeComponents) { result in
            completion(result)
        }
    }

    func getHomeBeveragesData(productCD: String, completion: @escaping (Result<(BeverageImageDTO?, BeverageInfoDTO?), NetworkError>) -> Void) {
        homeService.fetchData(of: .fetchBeverageImages(productCD)) { result in
            completion(result)
        }

        homeService.fetchData(of: .fetchBeverageInfo(productCD)) { result in
            completion(result)
        }
    }
}
