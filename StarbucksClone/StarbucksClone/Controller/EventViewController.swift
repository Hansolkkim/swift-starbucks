//
//  EventViewController.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import UIKit

class EventViewController: UIViewController {

    private lazy var eventView = EventView(frame: view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        view = eventView
    }
}
