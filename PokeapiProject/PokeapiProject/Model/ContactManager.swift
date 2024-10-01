//  ContactManager.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//

import Foundation

class ContactManager {
    static let shared = ContactManager() // 싱글톤 인스턴스
    private let contactsKey = "contacts" // 데이터를 저장할 키

    // 연락처 데이터를 디스크에 저장하는 메서드
    func saveFriend(_ friend: Friend) {
        var friends = loadFriends() // 기존의 연락처 데이터를 불러옴
        if let index = friends.firstIndex(where: { $0.name == friend.name && $0.phoneNumber == friend.phoneNumber }) {
            friends[index] = friend // 기존 데이터를 업데이트
        } else {
            friends.append(friend) // 새로운 연락처 데이터를 배열에 추가
        }
        friends.sort { $0.name < $1.name } // 이름순으로 정렬
        if let data = try? JSONEncoder().encode(friends) {
            UserDefaults.standard.set(data, forKey: contactsKey) // 인코딩된 JSON 데이터를 UserDefaults에 저장
        }
    }

    // 디스크에서 연락처 데이터를 불러오는 메서드
    func loadFriends() -> [Friend] {
        if let data = UserDefaults.standard.data(forKey: contactsKey), // UserDefaults에서 데이터를 불러옴
           let friends = try? JSONDecoder().decode([Friend].self, from: data) { // 불러온 데이터를 디코딩하여 [Friend] 배열로 변환
            return friends.sorted { $0.name < $1.name } // 이름순으로 정렬하여 반환
        }
        return []
    }

    // 특정 연락처를 업데이트하는 메서드
    func updateFriend(_ friend: Friend, with newFriend: Friend) {
        var friends = loadFriends()
        if let index = friends.firstIndex(where: { $0.name == friend.name && $0.phoneNumber == friend.phoneNumber }) {
            friends[index] = newFriend
            friends.sort { $0.name < $1.name }
            if let data = try? JSONEncoder().encode(friends) {
                UserDefaults.standard.set(data, forKey: contactsKey)
            }
        }
    }

    // 특정 연락처를 삭제하는 메서드
    func deleteFriend(_ friend: Friend) {
        var friends = loadFriends()
        if let index = friends.firstIndex(where: { $0.name == friend.name && $0.phoneNumber == friend.phoneNumber }) {
            friends.remove(at: index)
            if let data = try? JSONEncoder().encode(friends) {
                UserDefaults.standard.set(data, forKey: contactsKey)
            }
        }
    }
}
