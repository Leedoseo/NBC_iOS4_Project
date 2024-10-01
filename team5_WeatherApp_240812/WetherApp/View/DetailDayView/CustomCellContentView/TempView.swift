//
//  TempView.swift
//  WetherApp
//
//  Created by 유민우 on 8/14/24.
//


// 상세날씨 페이지 CollectionViewCell 에 들어갈 '기온'contentView

import UIKit
import SnapKit

class TempView: UIView {
    
    // MARK: - Property
    
    private let view = UIView()
    
    // 최고 기온
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        label.textColor = .mainGreen
        label.textAlignment = .center
        return label
    }()
    
    // 최저 기온
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.text = "최저: 20°C"
        label.font = .systemFont(ofSize: 25)
        label.textColor = .mainGreen
        label.textAlignment = .center
        return label
    }()
    
    // 최고기온, 최저기온이 들어갈 스택뷰
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    // 날씨 아이콘이 들어갈 imageView
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .mainDarkGray
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mainGreen
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        [tempMaxLabel, tempMinLabel].forEach { stackView.addArrangedSubview($0) }
        
        tempMaxLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(25)
        }
        
        tempMinLabel.snp.makeConstraints {
            $0.top.equalTo(tempMaxLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(25)
        }
        
        [stackView, iconImageView].forEach { self.addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(160)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(160)
        }
    }
    
    func configure(with textMax: String, textMin: String, image: UIImage?) {
        tempMaxLabel.text = textMax
        tempMinLabel.text = textMin
        iconImageView.image = image
    }
}
