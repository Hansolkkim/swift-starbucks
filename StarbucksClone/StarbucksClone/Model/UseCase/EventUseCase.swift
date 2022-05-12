//
//  EventUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

final class EventUseCase {
    private let userDefaultManager = UserDefaultManager()
    private(set) var starbuckstDTO: StarbuckstDTO? {
        didSet{
            guard let title = starbuckstDTO?.title else { return }
            delegate?.eventTitleDidUpdate(title: title)
        }
    }
    weak var delegate: EventUsecaseDelegate?
    
    func saveNeverSeeAgainRequest() {
        userDefaultManager.saveEventNeverSeeAgain()
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        self.starbuckstDTO = starbuckstDTO
    }
}

protocol EventUsecaseDelegate: AnyObject {
    func eventTitleDidUpdate(title: String)
}
