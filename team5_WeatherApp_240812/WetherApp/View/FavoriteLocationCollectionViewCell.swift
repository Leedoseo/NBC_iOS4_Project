//
//  FavoriteLocationCollectionViewCell.swift
//  WetherApp
//
//  Created by 임혜정 on 8/20/24.
//

import UIKit
import SnapKit

class FavoriteLocationCollectionViewCell: UICollectionViewCell {
    static let id = "favoriteLocationCollectionViewCell"
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainGreen
        label.font = .systemFont(ofSize: 20)
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [locationLabel].forEach {
            self.addSubview($0)
        }
        
        locationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupCell() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.mainGreen.cgColor
    }
    
    func configure(_ location: SavedLocation) {
        locationLabel.text = location.name
    }
}
