//
//  DetailDaySectionHeaderView.swift
//  WetherApp
//
//  Created by 유민우 on 8/12/24.
//

import UIKit
import SnapKit

class DetailDaySectionHeaderView: UICollectionReusableView {
    
    // MARK: - Property
    
    static let id = "DetailDaySectionHeaderView"
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.text = "2024년 8월 13일"
        label.font = .boldSystemFont(ofSize: 23)
        label.textAlignment = .center
        label.textColor = .mainGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    private func setupUI() {
        addSubview(todayLabel)
        todayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-5)
        }
    }
    
    func configure(with text: String) {
        todayLabel.text = text
    }
}


