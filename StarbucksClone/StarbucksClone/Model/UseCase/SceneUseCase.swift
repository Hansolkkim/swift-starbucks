//
//  SceneUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

class SceneUseCase {
    private let userDefaultManager = UserDefaultManager()
    private let eventRepository = EventRepository()
    
    func selectRootViewController() -> ViewControllerType {
        guard userDefaultManager.getStringFromUserDefault(by: .userLoginToken) != nil else {
            return .LoginViewController
        }
        guard userDefaultManager.getBooleanFromUserDefault() != false else {
            return .EventViewController
        }
        return .HomeViewController
    }
    
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        eventRepository.getEventData(completion: { result in
            completion(result)
        })
    }
}
enum ViewControllerType {
    case LoginViewController
    case EventViewController
    case HomeViewController
}
