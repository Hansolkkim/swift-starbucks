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
        imageView.image = UIImage(named: "gucci")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .black
        imageView.layer.cornerRadius = 55
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    private func setupUI(){
        contentView.addSubview(basicView)
        basicView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.center.equalTo(self.snp.center)
        }
        
        basicView.addSubViews(imageView, titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(basicView).offset(5)
            make.centerX.equalTo(basicView.snp.centerX)
            make.width.height.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalTo(basicView).offset(10)
            make.trailing.equalTo(basicView).offset(-10)
            make.bottom.equalTo(basicView.snp.bottom)
        }
    }
    
    func setInfo(by product: ProductDescription){
        imageView.image = UIImage(data: product.imageData)
        titleLabel.text = product.title
    }
}
