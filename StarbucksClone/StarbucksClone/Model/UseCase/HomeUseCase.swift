//
//  HomeUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeManagable {
    func getHomeComponentsData(completion: @escaping (Result<HomeComponents, NetworkError>) -> Void)
}

final class HomeUseCase: HomeManagable {
    private var homeComponentsDataGettable: HomeComponentsGettable
    private let userDefaultManagable: Loginable
    weak var delegate: HomeUseCaseDelegate?

    init(homeComponentsDataGettable: HomeComponentsGettable, userDefaultManagable: Loginable = UserDefaultManager()) {
        self.homeComponentsDataGettable = homeComponentsDataGettable
        self.userDefaultManagable = userDefaultManagable
        self.homeComponentsDataGettable.setDelegate(delegate: self)
    }
    
    func getHomeComponentsData(completion: @escaping (Result<HomeComponents, NetworkError>) -> Void) {
        homeComponentsDataGettable.getHomeComponentsData()
    }

}

extension HomeUseCase: HomeRepositoryDelegate {
    func updateEventImageURL(url: String) {
        print("eventURL Success : \(url)")
    }
    
    func getHomeComponentsDataError(error: NetworkError) {
        print("getHomeComponentData error \(error)")
    }
    
    func getBeverageError(error: NetworkError) {
        print("getBeverage error \(error)")
    }
    
    func updateBeverageData(product: ProductDescription) {
        print("success!! product \(product)")
    }
}

protocol HomeUseCaseDelegate: AnyObject {
    func updateHomeComponents(_ components: HomeComponents)
}
