//
//  WeaterDetailCollectionViewCell.swift
//  WetherApp
//
//  Created by 유민우 on 8/13/24.
//

import UIKit
import SnapKit

final class WeaterDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let id = "WeaterDetailCollectionViewCell"
    private var customView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func configure(for item: Int, with data: CurrentWeatherResult, image: UIImage?) {
        // Cell 에 있는 기존의 서브 뷰 제거
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.backgroundColor = .green
        contentView.layer.cornerRadius = 15
        
        // 각 Cell 에 커스텀 뷰 추가 및 데이터 주입
        switch item {
        case 0:
            let tempView = TempView()
            tempView.configure(with: "최고: \(data.main.temp_max)°C, 최저: \(data.main.temp_min)°C", image: image)
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
            // 습도에 따라 상태메세지가 다르게 출력되는 메서드 만들것!
            contentView.addSubview(weatherMessageView)
            weatherMessageView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 4:
            let rainView = RainView()
            rainView.configure(with: "\(String(describing: data.rain?.threeHour))mm")
            contentView.addSubview(rainView)
            rainView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        case 5:
            let windView = WindView()
            windView.configure(with: "풍속: \(data.wind.speed)m/s, 풍향: \(data.wind.deg)") // 각도에 따라 바람방향을 정하는 계산메서드 만들것
            contentView.addSubview(windView)
            windView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        default:
            break
        }
    }
    
}
