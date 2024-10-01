//
//  File.swift
//  WetherApp
//
//  Created by 김동준 on 8/13/24.
//

import UIKit
import SnapKit

class ThreeHourlyCollectionViewCell: UICollectionViewCell {
    
//    let timeButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("시간", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        button.setTitleColor(.mainGreen, for: .normal)
//        button.backgroundColor = .clear
//        return button
//    }()
//    
//    let weatherButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "sun.max"), for: .normal)
//        button.backgroundColor = .clear
//        return button
//    }()
//    
//    let tempButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("온도", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//        button.setTitleColor(.mainGreen, for: .normal)
//        button.backgroundColor = .clear
//        return button
//    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .mainGreen
        return label
    }()
    
    private let threeHourWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .mainGreen
        return imageView
    }()
    
    private let threeHourTempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .mainGreen
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.addSubview(timeButton)
//        contentView.addSubview(threeHourWeatherIcon)
//        contentView.addSubview(tempButton)
        
//        timeButton.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//            $0.height.equalTo(20)
//        }
//        
//        tempButton.snp.makeConstraints {
//            $0.top.equalTo(threeHourWeatherIcon.snp.bottom).offset(5)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//        
//
//        tempButton.addTarget(self, action: #selector(tempButtonTapped), for: .touchUpInside)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [timeLabel, threeHourWeatherIcon, threeHourTempLabel].forEach {
            self.addSubview($0)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        threeHourWeatherIcon.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(8)
            $0.width.height.equalTo(26)
            $0.centerX.equalToSuperview()
        }
        
        threeHourTempLabel.snp.makeConstraints {
            $0.top.equalTo(threeHourWeatherIcon.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()

        }
    }
    
    func configure(with forecast: ForecastWeather, formatter: WeatherDataFormatter, iconName: String) {
        timeLabel.text = formatter.formatTimeString(forecast.dtTxt)
        threeHourWeatherIcon.image = UIImage(systemName: iconName)
        threeHourTempLabel.text = String(format: "%.0f°C", forecast.main.temp)
    }
}
