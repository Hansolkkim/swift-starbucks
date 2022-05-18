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
        label.text = "abcdefu"
        label.textAlignment = .center
        label.font.withSize(18)
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
        basicView.backgroundColor = .yellow
        basicView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.center.equalTo(self.snp.center)
        }
        
        basicView.addSubViews(imageView, titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(basicView).offset(5)
            make.centerX.equalTo(basicView.snp.centerX)
            make.width.height.equalTo(110)
            //make.bottom.equalTo(titleLabel.snp.top).offset(-10)
        }
        imageView.backgroundColor = .brown
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalTo(basicView).offset(10)
            make.trailing.equalTo(basicView).offset(-10)
            make.bottom.equalTo(basicView.snp.bottom).offset(-10)
        }
    }
    
    func setInfo(by product: ProductDTO){
        imageView.image = UIImage(named: product.imageData)
        titleLabel.text = product.title
    }
}
