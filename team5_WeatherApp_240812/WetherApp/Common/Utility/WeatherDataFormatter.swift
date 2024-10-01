//
//  WeatherDataFormatter.swift
//  WetherApp
//
//  Created by 임혜정 on 8/18/24.
//

import Foundation

class WeatherDataFormatter {
    static let shared = WeatherDataFormatter()
    
    private init() {}
    
    private let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
    
    private lazy var outputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = koreanTimeZone
        return formatter
    }()
    
    func formatTimeString(_ dateString: String) -> String {
        guard let utcDate = dateFormatter.date(from: dateString) else {
            return "시간 정보 없음"
        }
        
        let koreanDate = utcDate.addingTimeInterval(TimeInterval(koreanTimeZone.secondsFromGMT()))
        return outputFormatter.string(from: koreanDate)
    }
    
    func filterForecastData(_ forecasts: [ForecastWeather]) -> [ForecastWeather] {
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = koreanTimeZone
        
        return forecasts.filter { forecast in
            guard let utcDate = self.dateFormatter.date(from: forecast.dtTxt) else {
                print("Failed to parse date: \(forecast.dtTxt)")
                return false
            }
            
            // UTC 시간을 한국 시간으로 변환
            let koreanDate = utcDate.addingTimeInterval(TimeInterval(koreanTimeZone.secondsFromGMT()))
            
            // 오전 11시부터 오후 2시 사이의 데이터만 필터링 (더 넓은 범위)
            let hour = calendar.component(.hour, from: koreanDate)
            return hour >= 11 && hour <= 14
        }
    }
    
    func formatDayString(from dateString: String, isToday: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let forecastDate = dateFormatter.date(from: dateString) else {
            return "날짜 오류"
        }
        
        if isToday {
            return "오늘"
        } else {
            dateFormatter.dateFormat = "EEEE"  // 요일
            return dateFormatter.string(from: forecastDate)
        }
    }
    
    func filterThreeHourlyForecasts(_ forecasts: [ForecastWeather]) -> [ForecastWeather] {
        let koreanTimeZone = TimeZone(identifier: "Asia/Seoul")!
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = koreanTimeZone

        let filteredForecasts = forecasts.filter { forecast in
            guard let date = self.dateFormatter.date(from: forecast.dtTxt) else { return false }
            let koreanDate = date.addingTimeInterval(TimeInterval(koreanTimeZone.secondsFromGMT()))
            let hour = calendar.component(.hour, from: koreanDate)
            return hour % 3 == 0
        }

        return Array(filteredForecasts.prefix(8)) // 24시간 동안의 데이터 (3시간 * 8 = 24시간)
    }
    
    func translateWeatherCondition(_ condition: String) -> String {
        switch condition {
        case "Clear":
            return "맑음"
        case "Clouds", "Cloudy":
            return "흐림"
        case "Rain":
            return "비"
        case "Snow":
            return "눈"
        case "Thunderstorm":
            return "천둥번개"
        case "Drizzle":
            return "이슬비"
        case "Mist", "Fog":
            return "안개"
        default:
            return "알 수 없음"
        }
    }
    
    // 아이콘 이름 입력 작업해주세요 EX) Clear일시 sun.max
    func iconWeatherCondition(_ condition: String) -> String {
        switch condition {
        case "Clear":
            return "sun.max" // 맑음
        case "Clouds", "Cloudy":
            return "cloud" // 구름
        case "Rain":
            return "cloud.rain" // 비
        case "Snow":
            return "snow" // 눈
        case "Thunderstorm":
            return "cloud.bolt" // 천둥번개
        case "Drizzle":
            return "cloud.drizzle" // 이슬비
        case "Mist", "Fog":
            return "cloud.fog" // 안개
        default:
            return "moon" // 기본값 (밤)
        }
    }
    
    func windDirectionCalculation(_ wind: Double) -> String {
        switch wind {
        case 0..<22.5, 337.5..<360:
            return "북"
        case 22.5..<67.5:
            return "북동"
        case 67.5..<112.5:
            return "동"
        case 112.5..<157.5:
            return "동남"
        case 157.5..<202.5:
            return "남"
        case 202.5..<247.5:
            return "남서"
        case 247.5..<292.5:
            return "서"
        case 292.5..<337.5:
            return "북서"
        default:
            return "바람없음"
        }
    }
}
