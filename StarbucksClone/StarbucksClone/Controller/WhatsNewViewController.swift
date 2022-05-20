//
//  WhatsNewViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

class WhatsNewViewController: UIViewController {

    private lazy var whatsNewView = WhatsNewView(frame: view.frame)
    private let eventDataSource = WhatsNewCollectionDataSource()
    private var whatsNewManagable: WhatsNewManagable? = WhatsNewUseCase(whatsNewEventGettable: WhatsNewRepository(whatsNewService: WhatsNewService()))

    override func viewDidLoad() {
        super.viewDidLoad()
        view = whatsNewView
        whatsNewView.setEventCollectionDataSource(dataSource: eventDataSource)
        whatsNewManagable?.getEventData()
        whatsNewManagable?.setDelegate(delegate: self)
    }

    private func setWhatsNewEventCollectionData(event: WhatsNewEventDescription) {
        eventDataSource.events.append(event)

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.whatsNewView.eventCollectionView.insertItems(at: [IndexPath(item: self.eventDataSource.events.count - 1, section: 0)])
        }
    }
}

extension WhatsNewViewController: WhatsNewUseCaseDelegate {
    func updateEvent(event: WhatsNewEventDescription) {
        setWhatsNewEventCollectionData(event: event)
    }

    func updateEventsCount(count: Int) {
        eventDataSource.events = [WhatsNewEventDescription?](repeating: nil, count: count)
    }
}
