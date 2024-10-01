//
//  File.swift
//  WetherApp
//
//  Created by 유민우 on 8/19/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '날씨상태 메세지(코멘트)'contentView
import UIKit
import SnapKit

class WeatherMessageView: UIView {
    
    // MARK: - Property
    
    private let WeatherMassageLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘은 날씨가 매우 뜨겁습니다. \n 야외활동을 자제해 주세요"
        label.font = .systemFont(ofSize: 23)
        label.textColor = .black
        label.numberOfLines = 2
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
        self.addSubview(WeatherMassageLabel)
        
        WeatherMassageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(100)
            $0.width.equalTo(300)
        }
    }
}
