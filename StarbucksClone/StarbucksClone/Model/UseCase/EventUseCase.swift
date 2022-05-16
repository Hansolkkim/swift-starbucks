//
//  EventUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

protocol EventManagable {
    var starbuckstDTO: StarbuckstDTO? { get }
    func saveNeverSeeAgainRequest()
    func setEventDTO(starbuckstDTO: StarbuckstDTO)
}

final class EventUseCase {
    private let userDefaultManagable: EventNeverSeeDataSavable
    private(set) var starbuckstDTO: StarbuckstDTO?
    
    init(userDefaultManagable: EventNeverSeeDataSavable) {
        self.userDefaultManagable = userDefaultManagable
    }
}

extension EventUseCase: EventManagable {
    
    func saveNeverSeeAgainRequest() {
        userDefaultManagable.saveEventNeverSeeAgain()
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        self.starbuckstDTO = starbuckstDTO
    }
}
