//
//  WhatsNewTitleView.swift
//  StarbucksClone
//
//  Created by 김동준 on 2022/05/17.
//

import SnapKit

final class WhatsNewTitleView: UIView {
    private lazy var basicView = UIView(frame: self.frame)
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mail")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Whats New"
        label.textAlignment = .center
        label.font.withSize(18)
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI(){
        backgroundColor = .white
        addSubview(basicView)
        basicView.addSubview(iconView)
        basicView.addSubview(titleLabel)
        
        iconView.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.width.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(iconView.snp.trailing).offset(5)
        }
    }
}
