//  AddFriendViewController.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import UIKit
import SnapKit

class AddFriendViewController: UIViewController {
    let addFriendView = AddFriendView() // 연락처 추가 뷰
    let randomImageFetcher = RandomImageFetcher() // 랜덤 이미지 가져오는 클래스
    var friend: Friend? // 편집할 친구 정보

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // UI 설정

        // 랜덤 이미지 버튼이 클릭되었을 때 호출될 클로저 설정
        addFriendView.randomImageButtonTapped = { [weak self] in
            self?.fetchRandomImage()
        }

        // 친구 정보가 있을 경우 해당 정보를 설정
        if let friend = friend {
            configure(with: friend)
        }
    }

    private func setupUI() {
        // 연락처 추가 뷰를 뷰에 추가
        view.addSubview(addFriendView)
        // 제약조건 설정
        addFriendView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        title = friend?.name ?? "연락처 추가" // 네비게이션 타이틀 설정
        // 네비게이션 바에 적용 버튼 추가
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
    }

    @objc private func applyButtonTapped() {
        // 이름과 전화번호를 가져옴
        let name = addFriendView.nameTextView.text ?? ""
        let phoneNumber = addFriendView.phoneTextView.text ?? ""
        // 프로필 이미지를 데이터로 변환
        let profileImage = addFriendView.profileImageView.image
        let profileImageData = profileImage?.jpegData(compressionQuality: 0.8)

        // 새로운 연락처 데이터를 생성
        let newFriend = Friend(name: name, phoneNumber: phoneNumber, profileImageData: profileImageData)

        // 기존 연락처가 있으면 업데이트, 없으면 새로 추가
        if let friend = friend {
            ContactManager.shared.updateFriend(friend, with: newFriend)
        } else {
            ContactManager.shared.saveFriend(newFriend)
        }

        // 메인 화면으로 돌아가기
        navigationController?.popViewController(animated: true)
    }

    private func fetchRandomImage() {
        // 랜덤 이미지를 가져오는 메서드 호출
        randomImageFetcher.fetchRandomImage { [weak self] image in
            DispatchQueue.main.async {
                // 가져온 이미지를 프로필 이미지 뷰에 설정
                self?.addFriendView.profileImageView.image = image
            }
        }
    }

    // 친구 정보를 설정하는 메서드
    func configure(with friend: Friend) {
        addFriendView.nameTextView.text = friend.name
        addFriendView.phoneTextView.text = friend.phoneNumber
        if let imageData = friend.profileImageData {
            addFriendView.profileImageView.image = UIImage(data: imageData)
        } else {
            addFriendView.profileImageView.image = UIImage(systemName: "nil")
        }
    }
}
