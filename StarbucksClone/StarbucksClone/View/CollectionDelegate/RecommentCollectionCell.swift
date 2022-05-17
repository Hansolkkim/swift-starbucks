//
//  RecommentCollectionCell.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import SnapKit

final class RecommentCollectionCell: UICollectionViewCell {
    
    static let cellIdentifier = "RecommentCollectionCell"
    
    private lazy var basicView = UIView(frame: self.frame)
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mail")
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        contentView.addSubview(basicView)
        basicView.backgroundColor = .yellow
        basicView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.center.equalTo(self.snp.center)
        }
    }
}
