//
//  HomeEventCollectionCell.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

class HomeEventCollectionCell: UICollectionViewCell {
    static let cellIdentifier = "HomeEventCollectionCell"

    private lazy var basicView = UIView(frame: frame)

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        contentView.addSubViews(basicView)
        basicView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.center.equalTo(self.snp.center)
        }

        basicView.addSubViews(imageView, titleLabel)

        imageView.snp.makeConstraints { make in
            make.top.equalTo(basicView).offset(5)
            make.leading.equalTo(basicView)
            make.trailing.equalTo(basicView)
            make.centerY.equalTo(basicView)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(imageView)
            make.trailing.equalTo(basicView).offset(-10)
        }
    }

    func setInfo(by homeEvent: HomeEventDescription) {
        imageView.image = UIImage(data: homeEvent.imageData)
        titleLabel.text = homeEvent.title
    }
}
