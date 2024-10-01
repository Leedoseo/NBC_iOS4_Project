//
//  Friend.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import Foundation

// 연락처 정보를 저장할 구조체 정의
struct Friend: Codable {
    let name: String         // 친구의 이름
    let phoneNumber: String  // 친구의 전화번호
    let profileImageData: Data? // 친구의 프로필 이미지 데이터를 저장 (선택 사항)
}
