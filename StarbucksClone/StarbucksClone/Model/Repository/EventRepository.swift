//
//  EventRepository.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/12.
//

import Foundation

protocol EventDataGettable {
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void)
}

struct EventRepository: EventDataGettable {
    let eventService: EventDataFetchable

    init(eventService: EventDataFetchable) {
        self.eventService = eventService
    }
    
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        eventService.fetchData(of: .starbuckstLoading) { result in
            completion(result)
        }
    }
}
