//
//  WeaterDetailCollectionViewCell.swift
//  WetherApp
//
//  Created by 유민우 on 8/13/24.
//

import UIKit
import SnapKit

final class WeatherDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "WeaterDetailCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func configure(for item: Int, with data: CurrentWeatherResult, formatter: WeatherDataFormatter) {
        // Cell 에 있는 기존의 서브 뷰 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.backgroundColor = .mainDarkGray
        contentView.layer.borderColor = UIColor.mainGreen.cgColor
        contentView.layer.borderWidth = 1
        
        let weatherIconName = formatter.iconWeatherCondition(data.weather.first?.main ?? "moon")
        let weatherIconImage = UIImage(systemName: weatherIconName)
        
        // 각 Cell 에 커스텀 뷰 추가 및 데이터 주입
        switch item {
        case 0:
            let tempView = TempView()
            tempView.configure(with: "최고: \(data.main.temp_max)", textMin: "최저: \(data.main.temp_min)", image: weatherIconImage)
            contentView.addSubview(tempView)
            tempView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 1:
            let feelingTempView = FeelingTempView()
            feelingTempView.configure(with: "\(data.main.feels_like)°C")
            contentView.addSubview(feelingTempView)
            feelingTempView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 2:
            let humidityView = HumidityView()
            humidityView.configure(with: "\(data.main.humidity)%")
            contentView.addSubview(humidityView)
            humidityView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            } 
        case 3:
            let weatherMessageView = WeatherMessageView()
            let feelsLikeTemp = data.main.feels_like
            var weatherMessage: String = "오늘의 날씨"
            switch feelsLikeTemp {
            case ..<0:
                weatherMessage = "매우 춥습니다."
            case 0..<15:
                weatherMessage = "적당히 쌀쌀합니다."
            case 15..<23:
                weatherMessage = "날씨가 좋습니다."
            case 23..<32:
                weatherMessage = "다소 더운 날씨입니다."
            default:
                weatherMessage = "매우 덥습니다"
            }
            
            weatherMessageView.configure(with: weatherMessage)
            contentView.addSubview(weatherMessageView)
            weatherMessageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 4:
            let rainView = RainView()
            rainView.configure(with: "\(data.rain?.threeHour ?? 0)mm")
            contentView.addSubview(rainView)
            rainView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 5:
            let windView = WindView()
            let windDirection = formatter.windDirectionCalculation(data.wind.deg)
            windView.configure(with: "풍속: \(data.wind.speed)m/s", degText: "풍향: \(windDirection)풍")
            contentView.addSubview(windView)
            windView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        default:
            break
        }
    }
    
}
