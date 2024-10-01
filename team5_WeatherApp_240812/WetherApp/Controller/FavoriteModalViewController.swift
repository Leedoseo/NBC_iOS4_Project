//
//  FavoriteModalViewController.swift
//  WetherApp
//
//  Created by 임혜정 on 8/21/24.
//

import UIKit
import CoreLocation

class FavoriteModalViewController: ReusableViewController {
    private var forecastWeather: ForecastWeatherResult?
    var savedLocation: SavedLocation?
    
    private var favoriteModalView: MainView? {
        return view as? MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeatherData()
    }
    
    private func loadWeatherData() {
        guard let savedLocation = savedLocation else { return }
        
        let coordinate = CLLocationCoordinate2D(latitude: savedLocation.latitude, longitude: savedLocation.longitude)
        
        NetworkManager.shared.fetchCurrentWeatherData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
        
        NetworkManager.shared.fetchForecastData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            switch result {
            case .success(let forecastData):
                self?.forecastWeather = forecastData
                self?.forecastData = forecastData.list
                DispatchQueue.main.async {
                    self?.favoriteModalView?.collectionView.reloadData()
                    self?.favoriteModalView?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func updateUI() {
        guard let currentWeather = currentWeather else { return }
        
        favoriteModalView?.updateLocationLabel(savedLocation?.name ?? "알 수 없는 위치")
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        favoriteModalView?.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            favoriteModalView?.updateWeatherStatus(translatedStatus)
        }
        
        if let weatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(weatherIcon)
            favoriteModalView?.updateWeatherIcon(iconName)
        }
    }
}
