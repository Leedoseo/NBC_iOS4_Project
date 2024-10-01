//
//  WindView.swift
//  WetherApp
//
//  Created by 유민우 on 8/15/24.
//

// 상세날씨 페이지 CollectionViewCell 에 들어갈 '강수량'contentView
import UIKit
import SnapKit

class WindView: UIView {
    
    // MARK: - Property

    // 풍속
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.text = "풍속: 0.2m/s"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .mainGreen
        label.textAlignment = .left
        return label
    }()
    
    // 풍향
    private let degLabel: UILabel = {
        let label = UILabel()
        label.text = "풍향: 동남풍"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .mainGreen
        label.textAlignment = .left
        return label
    }()
    
    // 풍속, 풍향이 들어갈 스택뷰
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
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

        [speedLabel, degLabel].forEach { stackView.addArrangedSubview($0) }
        
        speedLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(20)
        }
        
        degLabel.snp.makeConstraints {
            $0.top.equalTo(speedLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(20)
        }
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with speedText: String, degText: String) {
        speedLabel.text = speedText
        degLabel.text = degText
    }
    
}
