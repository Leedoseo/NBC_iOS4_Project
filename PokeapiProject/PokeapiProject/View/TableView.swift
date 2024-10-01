//  TableView.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import UIKit

// 테이블 뷰 데이터 소스와 델리게이트를 구현하는 클래스
class FriendTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    var friends: [Friend] = [] // 친구 목록 배열

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.dataSource = self // 데이터 소스 설정
        self.delegate = self // 델리게이트 설정
        self.register(TableViewCell.self, forCellReuseIdentifier: "cell") // 커스텀 셀 등록
        self.backgroundColor = .white
        self.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // 구분선 여백
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 섹션 당 행의 수를 반환하는 메서드 (필수 데이터 소스 메서드)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count // 친구 목록의 수 반환
    }

    // 각 셀에 대한 설정을 수행하는 메서드 (필수 데이터 소스 메서드)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용 가능한 셀을 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        // 셀에 친구 이름과 전화번호 설정
        cell.nameLabel.text = friends[indexPath.row].name
        cell.phoneNumberLabel.text = friends[indexPath.row].phoneNumber
        
        // 프로필 이미지 설정
        if let imageData = friends[indexPath.row].profileImageData {
            cell.profileImageView.image = UIImage(data: imageData)
        } else {
            cell.profileImageView.image = UIImage(systemName: "nil")
        }
        return cell
    }

    // 테이블 뷰 셀의 높이를 반환하는 메서드 (선택적 델리게이트 메서드)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // 셀 높이 설정
    }
}
