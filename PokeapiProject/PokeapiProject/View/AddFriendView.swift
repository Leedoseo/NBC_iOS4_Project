//  AddFriendView.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import UIKit
import SnapKit

// AddFriendView 클래스 정의
class AddFriendView: UIView {
    let addLabel = UILabel() // 추가 레이블
    let profileImageView = UIImageView() // 프로필 이미지 뷰
    let applyButton = UIButton() // 적용 버튼
    let randomImageButton = UIButton() // 랜덤 이미지 버튼
    let nameTextView = UITextView() // 이름 입력 텍스트 뷰
    let phoneTextView = UITextView() // 전화번호 입력 텍스트 뷰

    // 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // UI 설정 메서드 호출
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI 설정 메서드
    private func setupUI() {
        backgroundColor = .white

        // 프로필 이미지 뷰 설정
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 100
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        addSubview(profileImageView)

        // 적용 버튼 설정
        applyButton.setTitle("적용", for: .normal)
        applyButton.setTitleColor(.blue, for: .normal)
        applyButton.backgroundColor = .clear
        addSubview(applyButton) 

        // 랜덤 이미지 버튼 설정
        randomImageButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomImageButton.setTitleColor(.lightGray, for: .normal)
        randomImageButton.backgroundColor = .clear
        randomImageButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addSubview(randomImageButton)

        // 이름 입력 텍스트 뷰 설정
        nameTextView.font = UIFont.systemFont(ofSize: 16)
        nameTextView.layer.borderColor = UIColor.lightGray.cgColor
        nameTextView.layer.borderWidth = 1
        nameTextView.layer.cornerRadius = 5
        addSubview(nameTextView)

        // 전화번호 입력 텍스트 뷰 설정
        phoneTextView.font = UIFont.systemFont(ofSize: 16)
        phoneTextView.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextView.layer.borderWidth = 1
        phoneTextView.layer.cornerRadius = 5
        addSubview(phoneTextView)

        setupConstraints()

        randomImageButton.addTarget(self, action: #selector(randomImageTapped), for: .touchUpInside)
    }

    // 랜덤 이미지 버튼 클릭 시 호출 메서드
    @objc private func randomImageTapped() {
        randomImageButtonTapped?()
    }

    // 랜덤 이미지 버튼 클릭 시 동작 클로저
    var randomImageButtonTapped: (() -> Void)?
    
    // 제약조건 설정 메서드
    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(200)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
        }

        randomImageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(150)
        }

        nameTextView.snp.makeConstraints {
            $0.top.equalTo(randomImageButton.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40)
        }

        phoneTextView.snp.makeConstraints {
            $0.top.equalTo(nameTextView.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(40) 
        }
    }
}
