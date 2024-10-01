//
//  CurrentWeatherResult.swift
//  WetherApp
//
//  Created by 이진규 on 8/13/24.
//


import Foundation 

// CurrentWeatherResult와 ForecastWeatherResult 모델 정의
struct CurrentWeatherResult: Codable {
    let weather: [Weather] // 날씨 정보 배열
    let main: WeatherMain // 주요 날씨 정보 (온도, 습도 등)
    let wind: Wind // 바람 정보 추가
    let rain: Rain? // 강수량 정보 추가 (비가 오지 않으면 없음)
}

struct Weather: Codable {
    let id: Int // 날씨 ID
    let main: String // 날씨 상태 (예: "Clear")
    let description: String // 날씨 설명 (예: "clear sky")
    let icon: String // 날씨 아이콘의 파일명
}

struct WeatherMain: Codable {
    let temp: Double // 현재 온도
    let temp_min: Double // 최저 온도
    let temp_max: Double // 최고 온도
    let humidity: Int // 습도
    let feels_like: Double // 체감 온도 추가
}

struct Wind: Codable {
    let speed: Double // 풍속 (m/s)
    let deg: Double // 풍향 (도)
    let gust: Double? // 돌풍 속도 (옵셔널)
}

struct Rain: Codable {
    let oneHour: Double? // 지난 1시간 동안의 강수량 (옵셔널)
    let threeHour: Double? // 지난 3시간 동안의 강수량 (옵셔널)

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

struct ForecastWeatherResult: Codable {
    let list: [ForecastWeather] // 날씨 예보 리스트
}

struct ForecastWeather: Codable {
    let main: WeatherMain // 주요 날씨 정보 (온도, 습도 등)
    let weather: [Weather]
    let dtTxt: String // 날짜와 시간 정보
    //여기에 계산 함수 추가

    enum CodingKeys: String, CodingKey {
        case main // JSON 키와 구조체 키의 매핑
        case weather
        case dtTxt = "dt_txt" // JSON에서 "dt_txt" 키를 "dtTxt" 변수와 매핑
    }
}
