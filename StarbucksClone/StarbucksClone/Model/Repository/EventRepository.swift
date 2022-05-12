//
//  EventRepository.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/12.
//

import Foundation

struct EventRepository {
    let eventService = EventService()
    
    func getEventData(completion: @escaping (Result<StarbuckstDTO, NetworkError>) -> Void) {
        eventService.fetchData(of: .starbuckstLoading) { result in
            completion(result)
        }
    }
}
