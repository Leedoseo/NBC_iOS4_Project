//
//  AddRegionViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/19/24.
//

import UIKit
import CoreLocation

class AddRegionViewController: ReusableViewController {
    private var forecastWeather: ForecastWeatherResult?
    private var savedLocationManager = SavedLocationManager.shared
    var locationName: String?
    var coordinate: CLLocationCoordinate2D?
    
    private var addRegionView: MainView? {
        return view as? MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRegionView?.addAddButton()
        addRegionView?.addCancelButton()
        setupCancelAddButton()
        fetchWeatherData()
    }
    
    private func setupCancelAddButton() {
        addRegionView?.addButton?.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addRegionView?.cancelButton?.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func fetchWeatherData() {
        guard let coordinate = coordinate else { return }
     
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.fetchCurrentWeatherData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let weatherData):
                self?.currentWeather = weatherData
            case .failure(let error):
                print(" \(error)")
            }
        }
        
        group.enter()
        NetworkManager.shared.fetchForecastData(lat: coordinate.latitude, lon: coordinate.longitude) { [weak self] result in
            defer { group.leave() }
            switch result {
            case .success(let forecastData):
                self?.forecastWeather = forecastData
                self?.forecastData = forecastData.list
            case .failure(let error): print(" \(error)")
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.updateUI()
        }
    }
    
    func updateUI() {
        guard let currentWeather = currentWeather else { return }
        
        addRegionView?.updateLocationLabel(locationName ?? "알 수 없는 위치")
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        addRegionView?.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            addRegionView?.updateWeatherStatus(translatedStatus)
        }
        
        if let weatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(weatherIcon)
            addRegionView?.updateWeatherIcon(iconName)
        }
        
        DispatchQueue.main.async {
                    self.addRegionView?.collectionView.reloadData()
                    self.addRegionView?.tableView.reloadData()
                }
    }
    
    @objc private func addButtonTapped() {
        guard
            let currentWeather = currentWeather,
            let locationName = locationName,
            let coordinate = coordinate 
        else {
            return
        }
        
        let savedLocation = SavedLocation(
            name: locationName,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            temp: currentWeather.main.temp,
            description: currentWeather.weather.first?.description ?? ""
        )
        
        SavedLocationManager.shared.saveLocation(savedLocation)
        
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("LocationAdded"), object: nil)
        }
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
