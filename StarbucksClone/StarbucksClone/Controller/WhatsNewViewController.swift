//
//  WhatsNewViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

class WhatsNewViewController: UIViewController, DependencySetable {
    typealias DependencyType = WhatsNewDependency

    var dependency: WhatsNewDependency? {
        didSet {
            self.whatsNewManagable = dependency?.manager
        }
    }
    private lazy var whatsNewView = WhatsNewView(frame: view.frame)
    private let eventDataSource = WhatsNewCollectionDataSource()
    private var whatsNewManagable: WhatsNewManagable?

    init() {
        super.init(nibName: nil, bundle: nil)
        DependencyInjector.injecting(to: self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        DependencyInjector.injecting(to: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = whatsNewView
        whatsNewView.setEventCollectionDataSource(dataSource: eventDataSource)
        whatsNewManagable?.getEventData()
        whatsNewManagable?.setDelegate(delegate: self)
    }

    func setDependency(dependency: WhatsNewDependency) {
        self.dependency = dependency
    }

    private func setWhatsNewEventCollectionData(event: WhatsNewEventDescription) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.eventDataSource.events[event.index]?.imageData = event.imageData
            self.whatsNewView.eventCollectionView.reloadItems(at: [IndexPath(item: event.index, section: 0)])
        }
    }
}

extension WhatsNewViewController: WhatsNewUseCaseDelegate {
    func updateEvent(event: WhatsNewEventDescription) {
        setWhatsNewEventCollectionData(event: event)
    }

    func updateEvents(_ dtos: [WhatsNewEventDTO]) {
        var descriptions = [WhatsNewEventDescription]()
        
        descriptions = dtos.enumerated().map {
            return WhatsNewEventDescription(title: $0.element.title, date: $0.element.startAt, index: $0.offset)
        }

        eventDataSource.events = descriptions
        DispatchQueue.main.async { [weak self] in
            self?.whatsNewView.eventCollectionView.reloadData()
        }
    }
}
