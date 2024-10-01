//
//  LocationModel.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import Foundation

// 위치 검색 결과를 위한 구조체
struct LocationResult: Codable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let state: String?
    let local_names: [String: String]?
}

extension LocationResult {
    func formattedKoreanLocationName() -> String {
        var components = [String]()
        
        // 대도시 또는 도 (state)
        if let state = state, state != name {
            components.append(state)
        }
        
        // 구 또는 시 (name이 구 또는 시일 수 있음)
        if let koreanName = local_names?["ko"] {
            if !components.contains(koreanName) {
                components.append(koreanName)
            }
        } else {
            components.append(name)
        }
        
        // 동 (local_names에서 추가 정보가 있다면)
        if let additionalInfo = local_names?["ko"], additionalInfo != name, !components.contains(additionalInfo) {
            components.append(additionalInfo)
        }
        
        return components.joined(separator: " ")
    }
}

// API에서 오류가 발생했을 때 처리하기 위한 구조체
struct ErrorResponse: Codable {
    let message: String
}

