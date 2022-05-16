//
//  EventViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import UIKit

class EventViewController: UIViewController, DependencySetable {
    typealias DependencyType = EventDependency
    var dependency: DependencyType? {
        didSet{
            self.eventManagable = dependency?.manager
        }
    }
    private lazy var eventView = EventView(frame: view.frame)
    private var eventManagable: EventManagable?

    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = eventView
        eventView.action = self

        if let title = eventManagable?.starbuckstDTO?.title {
            eventView.setTitleLabel(title: title)
        }
    }

    func setDependency(dependency: DependencyType) {
        self.dependency = dependency
    }
    
    func setEventDTO(starbuckstDTO: StarbuckstDTO){
        eventManagable?.setEventDTO(starbuckstDTO: starbuckstDTO)
    }
}

extension EventViewController: EventViewAction {
    func userDidInput(_ input: EventView.UserAction) {
        if input == .neverSeeAgainButtonTapped {
            eventManagable?.saveNeverSeeAgainRequest()
        }
        present(HomeViewController.create(), animated: true, completion: nil)
    }
}
