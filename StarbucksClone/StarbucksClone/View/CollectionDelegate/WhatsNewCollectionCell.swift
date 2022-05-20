//
//  WhatsNewCollectionCell.swift
//  StarbucksClone
//
//  Created by 김한솔 on 2022/05/19.
//

import UIKit

class WhatsNewCollectionCell: UICollectionViewCell {

    static let cellIdentifier = "WhatsNewCollectionCell"

    private lazy var basicView = UIView(frame: frame)

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.tintColor = .systemGray2
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
        contentView.addSubview(basicView)
        basicView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.center.equalTo(self.snp.center)
        }

        basicView.addSubViews(imageView, stackView)

        imageView.snp.makeConstraints { make in
            make.leading.equalTo(basicView).offset(25)
            make.trailing.equalTo(basicView.snp.leading).offset(110)
            make.top.equalTo(basicView.snp.top).offset(25)
            make.bottom.equalTo(basicView.snp.bottom)
        }

        stackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalTo(basicView.snp.trailing).offset(-10)
            make.centerY.equalTo(imageView)
        }

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
    }

    func setInfo(by whatsNewEvent: WhatsNewEventDescription) {
        imageView.image = UIImage(data: whatsNewEvent.imageData ?? Data())
        titleLabel.text = whatsNewEvent.title
        dateLabel.text = whatsNewEvent.date
    }
}
