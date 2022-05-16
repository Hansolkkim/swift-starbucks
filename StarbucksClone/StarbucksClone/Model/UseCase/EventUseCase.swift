//
//  EventUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

final class EventUseCase {
    private let userDefaultManager = UserDefaultManager()
    private(set) var starbuckstDTO: StarbuckstDTO?
    
    func saveNeverSeeAgainRequest() {
        userDefaultManager.saveEventNeverSeeAgain()
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        self.starbuckstDTO = starbuckstDTO
    }
}
