//  RandomImageFetcher.swift
//  PokeapiProject
//
//  Created by t2023-m0112 on 7/16/24.
//
// JSON 응답을 파싱하고 이미지 URL을 추출
                // JSON에서 URL을 가져온 후 데이터를 다운로드하여 이미지로 사용하는 경우, 데이터를 일시적으로 저장하는 곳이 필요하지만, 그러나 이 데이터는 메모리 내에서 처리되므로 디스크에 저장할 필요가 없다. 이미지를 다운로드하고 이를 UIImage로 변환한 후, 이를 UI에 반영한다. 이는 주로 메모리를 사용하여 처리된다. -> gpt 피셜
                // <Json은 gpt에게 물어가면서해서 이해가 아직 안되므로 따로 더 공부하기>
import UIKit

// 랜덤 이미지를 가져오는 클래스를 정의
class RandomImageFetcher {
    // 랜덤 이미지를 가져오는 메서드
    func fetchRandomImage(completion: @escaping (UIImage?) -> Void) {
        // 1부터 100 사이의 랜덤 숫자를 생성
        let randomNumber = Int.random(in: 1...100)
        // 랜덤 숫자를 포함한 URL 문자열을 생성
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomNumber)"
        // URL 문자열을 URL 객체로 변환
        guard let url = URL(string: urlString) else {
            completion(nil) // URL이 유효하지 않으면 nil을 반환
            return
        }
        
        // URL 요청 객체를 생성하고, HTTP 메서드를 GET으로 설정
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // URLSession을 사용하여 데이터 태스크를 생성 및 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 에러가 발생한 경우, 에러를 출력하고 nil을 반환
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // 데이터가 없는 경우, 로그를 출력하고 nil을 반환
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                // JSON 데이터를 파싱하여 딕셔너리로 변환
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // JSON 응답을 출력하여 확인
                    print("JSON response: \(json)")
                    
                    // JSON에서 이미지 URL을 추출
                    if let sprites = json["sprites"] as? [String: Any],
                       let imageUrlString = sprites["front_default"] as? String,
                       let imageUrl = URL(string: imageUrlString) {
                        
                        // 이미지 다운로드 메서드를 호출
                        self.downloadImage(from: imageUrl, completion: completion)
                    } else {
                        // JSON 구조가 예상과 다른 경우
                        print("Invalid JSON structure")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                } else {
                    // JSON 파싱이 실패한 경우
                    print("Invalid JSON structure")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                // JSON 파싱 중 에러가 발생한 경우
                print("Error parsing JSON: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume() // 데이터 태스크를 시작
    }

    // URL에서 이미지를 다운로드하는 메서드
    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // URLSession을 사용하여 데이터 태스크를 생성 및 실행
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 에러가 발생한 경우, 에러를 출력하고 nil을 반환
            if let error = error {
                print("Error downloading image: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // 데이터가 없거나 이미지 데이터가 유효하지 않은 경우
            guard let data = data, let image = UIImage(data: data) else {
                print("No data or invalid image data")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            // 다운로드한 이미지를 반환
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume() // 데이터 태스크를 시작
    }
}

