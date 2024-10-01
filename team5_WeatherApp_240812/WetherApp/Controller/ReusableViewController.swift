//
//  ReusableViewController.swift
//  WetherApp
//
//  Created by 임혜정 on 8/21/24.
//

import UIKit
import CoreLocation

class ReusableViewController: UIViewController {
    let mainView = MainView()
    let weatherDataManager = WeatherDataManager.shared
    var currentWeather: CurrentWeatherResult?
    var forecastData: [ForecastWeather] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.addBordersToCollectionView()
    }
    
    private func setupViews() {
        view.backgroundColor = .mainDarkGray
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        
    }
    
    
    private func showModal(viewController: UIViewController) {
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        self.present(viewController, animated: true)
    }
}

extension ReusableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeHourlyCollectionViewCell", for: indexPath) as? ThreeHourlyCollectionViewCell else {
            return UICollectionViewCell()
        }
        let threeHourlyForecasts = WeatherDataFormatter.shared.filterThreeHourlyForecasts(forecastData)
        let forecast = threeHourlyForecasts[indexPath.row]
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(with: forecast, formatter: WeatherDataFormatter.shared, iconName: iconName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailDayViewController = DetailDayViewController(weatherData: currentWeather, locationName: mainView.locationLabel.text)
        showModal(viewController: detailDayViewController)
    }
}

extension ReusableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherDataFormatter.shared.filterForecastData(forecastData).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        let dailyForecasts = WeatherDataFormatter.shared.filterForecastData(forecastData)
        let forecast = dailyForecasts[indexPath.row]
        
        let day = WeatherDataFormatter.shared.formatDayString(from: forecast.dtTxt, isToday: indexPath.row == 0)
        let temperature = "\(Int(forecast.main.temp))°C"
        let iconName = WeatherDataFormatter.shared.iconWeatherCondition(forecast.weather.first?.main ?? "")
        cell.configure(day: day, temperature: temperature, iconName: iconName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailDayViewController = DetailDayViewController(weatherData: currentWeather, locationName: mainView.locationLabel.text)
        showModal(viewController: detailDayViewController)
    }
    
    
}
