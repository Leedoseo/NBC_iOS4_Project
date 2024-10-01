//
//  RainView.swift
//  WetherApp
//
//  Created by 유민우 on 8/15/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '강수량'contentView
import UIKit
import SnapKit

class RainView: UIView {
    
    // MARK: - Property
    
    // 타이틀
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "강수량"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .mainGreen
        label.textAlignment = .center
        return label
    }()
    
    // 강수량
    private let rainLabel: UILabel = {
        let label = UILabel()
        label.text = "강수량: 1mm"
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .mainGreen
        label.textAlignment = .left
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
    
        [titleLabel, rainLabel].forEach { self.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        rainLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(40)
        }
 
    }
    
    func configure(with text: String) {
        rainLabel.text = text
    }
    
}
