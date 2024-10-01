//
//  TableViewCell.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    let profileImageView = UIImageView() // 프로필 사진 이미지 뷰
    let nameLabel = UILabel() // 이름 레이블
    let phoneNumberLabel = UILabel() // 전화번호 레이블

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // UI 설정 메서드 호출
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(profileImageView)

        nameLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(nameLabel)

        phoneNumberLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(phoneNumberLabel)

        setupConstraints() // 제약조건 설정
    }

    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.left.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.left.equalTo(profileImageView.snp.right).offset(30)
            $0.centerY.equalToSuperview()
        }

        phoneNumberLabel.snp.makeConstraints {
            $0.left.equalTo(nameLabel.snp.right).offset(8)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-30) 
        }
    }
}
