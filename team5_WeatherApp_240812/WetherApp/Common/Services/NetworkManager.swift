//
//  NetworkManager.swift
//  WetherApp
//
//  Created by 이진규 on 8/13/24.
//

//import UIKit
//
//class NetworkManager {
//    static let shared = NetworkManager() // 싱글톤 패턴 인스턴스를 생성
//    private let apiKey = "1ad11a058dd751ada3c5aa999ddc64a8" // API 키를 저장합니다.
//    private let baseUrl = "https://api.openweathermap.org/data/2.5" // API의 기본 URL을 저장합니다.
//    
//    private init() {} // 외부에서 인스턴스를 생성하지 못하도록 private 생성자를 만듭니다.
//    // 자원의 낭비? api 하나 하는 것이 좋을지 두개 쓰는 것이 좋을지
//    // 공통 네트워크 요청 메서드
//    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void) {
//        print("Requesting data from URL: \(url.absoluteString)")
//        let session = URLSession(configuration: .default) // 기본 설정으로 URLSession 인스턴스를 생성합니다.
//        session.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard let data = data, error == nil else {
//                print("데이터 로드 실패") // 데이터 로드 실패 시 메시지 출력
//                completion(nil) // nil 반환
//                return
//            }
//            // http status code 성공 범위.
//            let successRange = 200..<300
//            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
//                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
//                    print("JSON 디코딩 실패") // JSON 디코딩 실패 시 메시지 출력
//                    completion(nil) // nil 반환
//                    return
//                }
//                completion(decodedData) // 디코딩 성공 시 데이터를 반환
//            } else {
//                print("응답 오류") // 응답 오류 시 메시지 출력
//                completion(nil) // nil 반환
//            }
//        }.resume() // 요청 시작
//    }
//    
//    // 서버에서 현재 날씨 데이터를 불러오는 메서드
//    func fetchCurrentWeatherData(lat: Double, lon: Double, completion: @escaping (CurrentWeatherResult?, UIImage?) -> Void) {
//        // URLComponents를 사용하여 URL을 구성합니다.
//        var urlComponents = URLComponents(string: "\(baseUrl)/weather")
//        urlComponents?.queryItems = [
//            URLQueryItem(name: "lat", value: "\(lat)"), // 위도
//            URLQueryItem(name: "lon", value: "\(lon)"), // 경도
//            URLQueryItem(name: "appid", value: apiKey), // API 키
//            URLQueryItem(name: "units", value: "metric"), // 온도 단위를 섭씨로 설정
//            URLQueryItem(name: "cnt", value: "40"),  // 5일치 3시간 간격 데이터
//            URLQueryItem(name: "timezone", value: "Asia/Seoul")  // 한국 시간대 지정
//        ]
//        // 어디를 바꿔야 url api, CurrentWeatherResult를 말고도 다른 데이터를 변형해서 받는 법을 알아야 한다.
//        
//        // URL이 제대로 생성되지 않은 경우 처리
//        guard let url = urlComponents?.url else {
//            print("잘못된 URL") // URL 생성 실패 시 메시지 출력
//            completion(nil, nil) // completion 클로저를 통해 nil 반환
//            return
//        }
//        
//        // 데이터를 가져오는 공통 메서드를 호출
//        fetchData(url: url) { (result: CurrentWeatherResult?) in
//            // 데이터를 성공적으로 가져왔는지 확인
//            guard let result = result else {
//                completion(nil, nil) // 실패 시 nil 반환 클로저 활용해서 넘긴다 18번째 줄 참고
//                return
//            }
//            
//            // 날씨 아이콘을 불러오기 위해 아이콘 URL 생성
//            guard let icon = result.weather.first?.icon,
//                  let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
//                completion(result, nil) // 아이콘 URL 생성 실패 시 데이터만 반환
//                return
//            }
//            
//            // 이미지를 불러옴
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        completion(result, image) // 성공적으로 이미지 로드 시 이미지와 데이터를 반환
//                    }
//                } else {
//                    DispatchQueue.main.async {
//                        completion(result, nil) // 이미지 로드 실패 시 데이터만 반환
//                    }
//                }
//            }
//        }
//    }
//    
//    // 서버에서 5일 간의 날씨 예보 데이터를 불러오는 메서드
//    func fetchForecastData(lat: Double, lon: Double, completion: @escaping (ForecastWeatherResult?) -> Void) {
//        // URLComponents를 사용하여 URL을 구성합니다.
//        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")
//        urlComponents?.queryItems = [
//            URLQueryItem(name: "lat", value: "\(lat)"), // 위도
//            URLQueryItem(name: "lon", value: "\(lon)"), // 경도
//            URLQueryItem(name: "appid", value: apiKey), // API 키
//            URLQueryItem(name: "units", value: "metric"), // 온도 단위를 섭씨로 설정
//            URLQueryItem(name: "cnt", value: "40"),  // 5일치 3시간 간격 데이터
//            URLQueryItem(name: "timezone", value: "Asia/Seoul")  // 한국 시간대 지정
//        ]
//        
//        // URL이 제대로 생성되지 않은 경우 처리
//        guard let url = urlComponents?.url else {
//            print("잘못된 URL") // URL 생성 실패 시 메시지 출력
//            completion(nil) // completion 클로저를 통해 nil 반환
//            return
//        }
//        
//        // 데이터를 가져오는 공통 메서드를 호출
//        fetchData(url: url, completion: completion) // 제네릭을 활용해 다양한 타입의 데이터 처리가 가능
//    }
//}

import Foundation

enum APIEndpoint: String {
    case currentWeather = "weather"
    case forecast = "forecast"
}

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "1ad11a058dd751ada3c5aa999ddc64a8"
    private let baseUrl = "https://api.openweathermap.org/data/2.5"
    
    private init() {}
    
    private func createURL(endpoint: APIEndpoint, lat: Double, lon: Double, additionalParams: [String: String] = [:]) -> URL? {
        var urlComponents = URLComponents(string: "\(baseUrl)/\(endpoint.rawValue)")
        var queryItems = [
            URLQueryItem(name: "lat", value: "\(lat)"),
            URLQueryItem(name: "lon", value: "\(lon)"),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "timezone", value: "Asia/Seoul")
        ]
        
        for (key, value) in additionalParams {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
    
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCurrentWeatherData(lat: Double, lon: Double, completion: @escaping (Result<CurrentWeatherResult, Error>) -> Void) {
        guard let url = createURL(endpoint: .currentWeather, lat: lat, lon: lon) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        fetchData(url: url, completion: completion)
    }
    
    func fetchForecastData(lat: Double, lon: Double, completion: @escaping (Result<ForecastWeatherResult, Error>) -> Void) {
        guard let url = createURL(endpoint: .forecast, lat: lat, lon: lon, additionalParams: ["cnt": "40"]) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        fetchData(url: url, completion: completion)
    }
    
    func fetchLocations(for query: String, completion: @escaping (Result<[LocationResult], Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=5&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        fetchData(url: url, completion: completion)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}
