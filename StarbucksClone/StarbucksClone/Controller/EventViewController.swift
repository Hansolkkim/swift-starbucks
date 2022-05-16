//
//  EventViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import UIKit

class EventViewController: UIViewController {

    private lazy var eventView = EventView(frame: view.frame)
    private var usecase: EventManagable?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = eventView
        eventView.action = self
        eventView.setTitleLabel(title: usecase.starbuckstDTO?.title ?? "nil")
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        usecase?.setEventDTO(starbuckstDTO: starbuckstDTO)
    }
}

extension EventViewController: EventViewAction {
    func userDidInput(_ input: EventView.UserAction) {
        if input == .neverSeeAgainButtonTapped {
            usecase?.saveNeverSeeAgainRequest()
        }
        present(HomeViewController.create(), animated: true, completion: nil)
    }
}
