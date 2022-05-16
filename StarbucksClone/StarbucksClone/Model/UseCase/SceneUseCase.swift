//
//  SceneUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

protocol SceneManagable{
    func selectRootViewController() -> ViewControllerType
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void)
}

final class SceneUseCase {
    private let userDefaultManagable: SceneUserDefaultManagable
    private let eventRepository = EventRepository()
    
    init(userDefaultManagable: SceneUserDefaultManagable) {
        self.userDefaultManagable = userDefaultManagable
    }
}

extension SceneUseCase: SceneManagable {
    func selectRootViewController() -> ViewControllerType {
        guard userDefaultManagable.getStringFromUserDefault(by: .userLoginToken) != nil else {
            return .LoginViewController
        }
        guard userDefaultManagable.getBooleanFromUserDefault() else {
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
