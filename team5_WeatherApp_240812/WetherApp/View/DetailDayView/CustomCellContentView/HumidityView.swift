//
//  humidityView.swift
//  WetherApp
//
//  Created by 유민우 on 8/14/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '습도'contentView
import UIKit
import SnapKit

class HumidityView: UIView {
    
    // MARK: - Property
    
    // 타이틀
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "습도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .mainGreen
        label.textAlignment = .center
        return label
    }()
    
    // 습도
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "60%"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .mainGreen
        label.textAlignment = .center
        return label
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
        
        [titleLabel, humidityLabel].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        humidityLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    func configure(with text: String) {
        humidityLabel.text = text
    }
    
}
