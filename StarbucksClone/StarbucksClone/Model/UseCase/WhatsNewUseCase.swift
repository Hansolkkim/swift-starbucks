//
//  WhatsNewUseCase.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import Foundation

protocol WhatsNewManagable {
    func getEventData()
    func setDelegate(delegate: WhatsNewUseCaseDelegate)
}

final class WhatsNewUseCase: WhatsNewManagable {
    private var whatsNewEventGettable: WhatsNewEventGettable
    weak var delegate: WhatsNewUseCaseDelegate?

    init(whatsNewEventGettable: WhatsNewEventGettable) {
        self.whatsNewEventGettable = whatsNewEventGettable
        self.whatsNewEventGettable.setDelegate(delegate: self)
    }

    func getEventData() {
        whatsNewEventGettable.getWhatsNewEventData()
    }
    
    func setDelegate(delegate: WhatsNewUseCaseDelegate) {
        self.delegate = delegate
    }
}

extension WhatsNewUseCase: WhatsNewRepositoryDelegate {

    func updateEventData(event: WhatsNewEventDescription) {
        delegate?.updateEvent(event: event)
    }
    
    func getWhatsNewEventError(error: NetworkError) {
        print("getWhatsNewEventError \(error)")
    }

    func setWhatsNewEventDTOs(_ dtos: [WhatsNewEventDTO]) {
        delegate?.updateEvents(dtos)
    }
}

protocol WhatsNewUseCaseDelegate: AnyObject {
    func updateEvent(event: WhatsNewEventDescription)
    func updateEvents(_ dtos: [WhatsNewEventDTO])
}
