//
//  Information.swift
//  UITest
//
//  Created by 박승환 on 5/27/24.
//

import Foundation

struct Info {
    var name:String             // 이름
    var age:Int                 // 나이
    var area: String            // 사는곳
    var MBTI: String            // MBTI
    var position: String        // 역할
    var introduce: String       // 자기소개
    var blogURL: String         // 블로그 URL
    var gitHubURL: String       // 깃허브 URL
}

class Information {
    static let shared = Information()
    
    var peoples = Array<Info>()
    
    let names = ["김동현", "김광현", "박승환", "유민우", "이주희", "최건"]
    let ages = [29, 27, 26, 25, 30, 29]
    let areas = ["인천", "화성", "서울", "강릉", "전주", "양평"]
    let MBTIs = ["ESFJ", "INTJ", "ISFP", "ESTJ", "INFP", "ISFP"]
    let positions = ["팀장", "부팀장", "팀원", "팀원", "팀원", "팀원"]
    let introduces = [
        "화이팅 입니다!1년 남았다..",
        "30 많이 남았다!!",
        "4년은 길다!",
        "아직 5년 남았다!",
        "30은 별거 없다!",
        "30이 코앞이다..."
    ]
    let urls = [
        "https://how-dev.tistory.com/",
        "https://leedoseo.tistory.com/",
        "https://shpark0920.tistory.com/",
        "https://velog.io/@zxcv123248/posts",
        "https://velog.io/@leejh950417/posts",
        "https://velog.io/@geon5595/posts"
    ]
    
    let gitHubURLs = [
        "https://github.com/Kim-Dong-Hyeon",
        "https://github.com/Leedoseo",
        "https://github.com/sh990920",
        "https://github.com/min1woo",
        "https://github.com/jjoohee95",
        "https://github.com/geon5595"
    ]
    
    let images = [
        "김동현" : "kdh",
        "김광현" : "kkh",
        "박승환" : "psh",
        "유민우" : "umy",
        "이주희" : "ljh",
        "최건" : "ck"
    ]
    
    private init() {
        setting()
    }
    
    // 기본 세팅
    func setting() {
        if peoples.isEmpty {
            for i in 0..<6 {
                let people = Info(name: names[i], age: ages[i], area: areas[i], MBTI: MBTIs[i], position: positions[i], introduce: introduces[i], blogURL: urls[i], gitHubURL: gitHubURLs[i])
                peoples.append(people)
            }
        }
    }
    
    // 사람 검색
    func findUser(_ name: String) -> Info {
        var info: Info = Info(name: "nil", age: 0, area: "nil", MBTI: "nil", position: "nil", introduce: "nil", blogURL: "nil", gitHubURL: "nil")
        for i in peoples {
            if i.name == name {
                info = i
            }
        }
        return info
    }
    
    // 사람 정보 업데이트
    func updateUser(_ updatedInfo: Info) {
        if let index = peoples.firstIndex(where: { $0.name == updatedInfo.name }) {
            peoples[index] = updatedInfo
        }
    }

}
