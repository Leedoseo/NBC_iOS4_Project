//
//  ListCollectionViewCell.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        contentView.backgroundColor = .mainDarkGray
        contentView.layer.cornerRadius = 8
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Configure Method
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
