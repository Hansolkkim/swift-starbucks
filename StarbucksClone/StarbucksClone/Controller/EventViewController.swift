//
//  EventViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import UIKit

class EventViewController: UIViewController {

    private lazy var eventView = EventView(frame: view.frame)
    private let usecase = EventUseCase()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = eventView
        
        eventView.action = self
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        usecase.delegate = self
        usecase.setEventDTO(starbuckstDTO: starbuckstDTO)
    }
}

extension EventViewController: EventViewAction {
    func userDidInput(_ input: EventView.UserAction) {
        if input == .neverSeeAgainButtonTapped {
            usecase.saveNeverSeeAgainRequest()
        }
        // TODO: HomeVC로 이동
    }
}

extension EventViewController: EventUsecaseDelegate{
    func eventTitleDidUpdate(title: String) {
        DispatchQueue.main.async { [weak self] in
            self?.eventView.setTitleLabel(title: title)
        }
    }
}
