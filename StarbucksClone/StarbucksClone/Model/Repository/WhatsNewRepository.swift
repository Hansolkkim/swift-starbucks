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

final class WhatsNewRepository: WhatsNewEventGettable {

    let whatsNewService: WhatsNewEventDataFetchable
    weak var delegate: WhatsNewRepositoryDelegate?
    var descriptions: [WhatsNewEventDescription]?

    init(whatsNewService: WhatsNewEventDataFetchable) {
        self.whatsNewService = whatsNewService
    }

    func getWhatsNewEventData() {
        whatsNewService.fetchData(of: .fetchWhatsNewEventData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let whatsNewDTOs):
                self.getWhatsNewEvent(events: whatsNewDTOs)
                self.delegate?.setWhatsNewEventDTOs(whatsNewDTOs)
            case .failure(let error):
                self.delegate?.getWhatsNewEventError(error: error)
            }
        }
    }

    func setDelegate(delegate: WhatsNewRepositoryDelegate) {
        self.delegate = delegate
    }

    private func getWhatsNewEvent(events: [WhatsNewEventDTO]) {
        for (index, event) in events.enumerated() {
            var description = WhatsNewEventDescription(title: event.title, date: event.startAt, index: index)

            whatsNewService.fetchImage(of: event.imageURL) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageData):
                    description.imageData = imageData
                    self.delegate?.updateEventData(event: description)
                case .failure(let error):
                    self.delegate?.getWhatsNewEventError(error: error)
                }
            }
        }
    }
}

protocol WhatsNewRepositoryDelegate: AnyObject {
    func updateEventData(event: WhatsNewEventDescription)
    func getWhatsNewEventError(error: NetworkError)
    func setWhatsNewEventDTOs(_ dtos: [WhatsNewEventDTO])
}
