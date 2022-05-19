//
//  HomeUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/17.
//

import Foundation

protocol HomeManagable {
    func getHomeComponentsData()
    func setDelegate(delegate: HomeUseCaseDelegate)
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
    
    func getHomeComponentsData() {
        guard let nickName = userDefaultManagable.getStringFromUserDefault(by: .userNickname) else { return }
        delegate?.updateUserNickname(nickName + "님을 위한 추천 메뉴")
        homeComponentsDataGettable.getHomeComponentsData()
    }
    
    func setDelegate(delegate: HomeUseCaseDelegate) {
        self.delegate = delegate
    }

}

extension HomeUseCase: HomeRepositoryDelegate {
    func updateMainEventImage(data: Data) {
        delegate?.updateMainEventImageData(data: data)
    }
    
    func updateBeverageData(product: ProductDescription) {
        delegate?.updateBeverage(product: product)
    }
    
    func getHomeComponentsDataError(error: NetworkError) {
        print("getHomeComponentData error \(error)")
    }

    func updateEventData(event: HomeEventDescription) {
        delegate?.updateEvent(event)
    }
    
    func getBeverageError(error: NetworkError) {
        print("getBeverage error \(error)")
    }

    func getImageDataError(error: NetworkError) {
        print("getimageData error \(error)")
    }

    func getHomeEventError(error: NetworkError) {
        print("getHomeEvent Error \(error)")
    }
}

protocol HomeUseCaseDelegate: AnyObject {
    func updateUserNickname(_ nickName: String)
    func updateHomeComponents(_ components: HomeComponents)
    func updateMainEventImageData(data: Data)
    func updateBeverage(product: ProductDescription)
    func updateEvent(_ event: HomeEventDescription)
}
