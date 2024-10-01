//  FriendListViewController.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    let friendListView = FriendListViewLabel() // 친구 목록 뷰
    var friends: [Friend] = [] // 연락처 데이터 배열

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(friendListView)

        friendListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        // 테이블 뷰 데이터 소스와 델리게이트 설정
        friendListView.tableView.dataSource = self
        friendListView.tableView.delegate = self

        // 셀 클래스 등록
        friendListView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")

        // 추가 버튼 액션 설정
        friendListView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 저장된 연락처 데이터를 로드하여 이름순으로 정렬
        friends = ContactManager.shared.loadFriends()
        // 테이블 뷰를 리로드하여 데이터를 업데이트
        friendListView.tableView.reloadData()
    }

    @objc private func addButtonTapped() {
        // 연락처 추가 화면으로 이동
        let addFriendVC = AddFriendViewController()
        navigationController?.pushViewController(addFriendVC, animated: true)
    }
}

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    // 섹션 당 행의 수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    // 각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let friend = friends[indexPath.row]
        cell.nameLabel.text = friend.name // 친구 이름 설정
        cell.phoneNumberLabel.text = friend.phoneNumber // 친구 전화번호 설정
        if let imageData = friend.profileImageData {
            cell.profileImageView.image = UIImage(data: imageData) // 프로필 이미지 설정
        } else {
            cell.profileImageView.image = UIImage(systemName: "nil") // 기본 프로필 이미지 설정
        }
        return cell
    }

    // 셀 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    // 셀 선택 시 호출되는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriend = friends[indexPath.row]
        let addFriendVC = AddFriendViewController()
        addFriendVC.friend = selectedFriend // 선택된 친구 정보를 설정
        navigationController?.pushViewController(addFriendVC, animated: true)
    }

    // 셀 삭제를 위한 메서드 추가
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 연락처 배열에서 삭제
            let friendToDelete = friends.remove(at: indexPath.row)
            // 디스크에서 연락처 삭제
            ContactManager.shared.deleteFriend(friendToDelete)
            // 테이블 뷰에서 셀 삭제
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
