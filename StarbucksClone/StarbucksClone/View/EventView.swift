//
//  EventView.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/11.
//

import SnapKit

final class EventView: UIView {
    
    weak var action: EventViewAction?
    
    private let outerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#DCEAE2")
        return view
    }()
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "eventImage")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let neverSeeAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시보지않기", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 30
        return button
    }()
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("닫기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius = 30
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        addAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        setupLayout()
        addAction()
    }

    private func setupLayout() {
        addSubview(outerView)
        outerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.bottom.equalTo(snp.bottom).offset(-150)
        }
        
        outerView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints { make in
            make.top.equalTo(outerView.snp.top).offset(30)
            make.trailing.leading.equalTo(outerView)
            make.bottom.equalTo(outerView.snp.bottom)
        }

        addSubview(neverSeeAgainButton)
        neverSeeAgainButton.snp.makeConstraints { make in
            make.top.equalTo(outerView.snp.bottom).offset(10)
            make.leading.equalTo(snp.leading).offset(15)
            make.trailing.equalTo(snp.centerX).offset(-10)
            make.bottom.equalTo(snp.bottom).offset(-80)
        }

        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(neverSeeAgainButton.snp.centerY)
            make.leading.equalTo(snp.centerX).offset(10)
            make.height.equalTo(neverSeeAgainButton)
            make.trailing.equalTo(snp.trailing).offset(-15)
        }
    }
    
    private func addAction() {
        neverSeeAgainButton.addAction(UIAction (handler: { [weak self] _ in
            self?.action?.userDidInput(.neverSeeAgainButtonTapped)
        }) , for: .touchUpInside)
        
        closeButton.addAction(UIAction (handler: { [weak self] _ in
            self?.action?.userDidInput(.closeButtonTapped)
        }) , for: .touchUpInside)
    }
}

extension EventView {
    enum UserAction {
        case closeButtonTapped
        case neverSeeAgainButtonTapped
    }
}

protocol EventViewAction: AnyObject{
    func userDidInput(_ input: EventView.UserAction)
}
