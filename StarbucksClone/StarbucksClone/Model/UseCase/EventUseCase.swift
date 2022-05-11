//
//  EventUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import Foundation

class EventUseCase {
    private let userDefaultManager = UserDefaultManager()

    func saveNeverSeeAgainRequest() {
        userDefaultManager.saveEventNeverSeeAgain()
    }
}
