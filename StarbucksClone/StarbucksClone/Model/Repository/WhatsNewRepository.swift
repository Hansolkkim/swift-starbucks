//
//  WhatsNewRepository.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import Foundation

protocol WhatsNewEventGettable {
    func getWhatsNewEventData()
    mutating func setDelegate(delegate: WhatsNewRepositoryDelegate)
}

struct WhatsNewRepository: WhatsNewEventGettable {

    let whatsNewService: WhatsNewEventDataFetchable
    var delegate: WhatsNewRepositoryDelegate?

    init(whatsNewService: WhatsNewEventDataFetchable) {
        self.whatsNewService = whatsNewService
    }

    func getWhatsNewEventData() {
        whatsNewService.fetchData(of: .fetchWhatsNewEventData) { result in
            switch result {
            case .success(let whatsNewDTOs):
                getWhatsNewEvent(events: whatsNewDTOs)
            case .failure(let error):
                delegate?.getWhatsNewEventError(error: error)
            }
        }
    }

    mutating func setDelegate(delegate: WhatsNewRepositoryDelegate) {
        self.delegate = delegate
    }

    private func getWhatsNewEvent(events: [WhatsNewEventDTO]) {
        for event in events {
            var description = WhatsNewEventDescription(imageData: Data(), title: event.title, date: event.startAt)

            whatsNewService.fetchImage(of: event.imageURL) { result in
                switch result {
                case .success(let imageData):
                    description.imageData = imageData
                    delegate?.updateEventData(event: description)
                case .failure(let error):
                    delegate?.getWhatsNewEventError(error: error)
                }
            }
        }
    }
}

protocol WhatsNewRepositoryDelegate: AnyObject {
    func updateEventData(event: WhatsNewEventDescription)
    func getWhatsNewEventError(error: NetworkError)
}
