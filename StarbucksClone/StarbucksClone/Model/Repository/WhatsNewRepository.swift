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
    var descriptions = [WhatsNewEventDescription]() {
        didSet {
            if descriptions.count == count {
                
            }
        }
    }
    var count = 0

    init(whatsNewService: WhatsNewEventDataFetchable) {
        self.whatsNewService = whatsNewService
    }

    func getWhatsNewEventData() {
        whatsNewService.fetchData(of: .fetchWhatsNewEventData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let whatsNewDTOs):
                self.count = whatsNewDTOs.count
                self.getWhatsNewEvent(events: whatsNewDTOs)
            case .failure(let error):
                self.delegate?.getWhatsNewEventError(error: error)
            }
        }
    }

    func setDelegate(delegate: WhatsNewRepositoryDelegate) {
        self.delegate = delegate
    }

    private func getWhatsNewEvent(events: [WhatsNewEventDTO]) {
        for event in events {
            var description = WhatsNewEventDescription(title: event.title, date: event.startAt)

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
}
