////
////  MainViewController.swift
////  WetherApp
////
////  Created by 임혜정 on 8/12/24.
////
//

import UIKit
import CoreLocation

class MainViewController: ReusableViewController {
    private var currentLocation: CLLocation?
    private let locationManager = LocationManager.shared
    
    private var mainMainView: MainView? {
        return view as? MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMainView?.addSearchPageButton()
        setupLocationManager()
        setupSearchPageButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestCurrentLocation()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestLocationAuthorization()
    }
    
    func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let lat = coordinate.latitude
        let lon = coordinate.longitude
        
        NetworkManager.shared.fetchCurrentWeatherData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let currentWeather):
                self?.currentWeather = currentWeather
                DispatchQueue.main.async {
                    self?.updateCurrentWeatherUI()
                }
            case .failure(let error):
                print("Failed to fetch current weather data: \(error)")
            }
        }
        
        NetworkManager.shared.fetchForecastData(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let forecast):
                self?.forecastData = forecast.list
                DispatchQueue.main.async {
                    self?.mainView.collectionView.reloadData()
                    self?.mainView.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch forecast data: \(error)")
            }
        }
    }
    
    func updateCurrentWeatherUI() {
        guard let currentWeather = currentWeather else { return }
        
        let formattedData = weatherDataManager.formatWeatherData(currentWeather)
        mainView.updateWeatherUI(with: formattedData)
        
        if let weatherStatus = currentWeather.weather.first?.main {
            let translatedStatus = WeatherDataFormatter.shared.translateWeatherCondition(weatherStatus)
            mainView.updateWeatherStatus(translatedStatus)
        }
        
        if let location = currentLocation {
            weatherDataManager.getLocationName(from: location) { [weak self] locationName in
                DispatchQueue.main.async {
                    self?.mainView.updateLocationLabel(locationName)
                }
            }
        }
        
        if let currentWeatherIcon = currentWeather.weather.first?.main {
            let iconName = WeatherDataFormatter.shared.iconWeatherCondition(currentWeatherIcon)
            mainView.updateWeatherIcon(iconName)
        }
    }
    
    private func setupSearchPageButton() {
        mainMainView?.searchPageButton?.addTarget(self, action: #selector(searchPageButtonTapped), for: .touchDown)
    }
    
    @objc private func searchPageButtonTapped() {
        let listViewController = ListViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(listViewController, animated: true)
        }
    }
}

// MARK: - 위치관련 , 분리 작업 예정

extension MainViewController: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation) {
        currentLocation = location
        fetchWeatherData(for: location.coordinate)
    }
    
    func locationManager(_ manager: LocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
        showLocationDeniedAlert()
    }
    
    private func showLocationDeniedAlert() {
        let alert = UIAlertController(
            title: "위치 접근 거부됨",
            message: "날씨 정보를 제공하기 위해 위치 접근 권한이 필요합니다. 설정에서 위치 접근을 허용해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel) { _ in
            let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
            self.fetchWeatherData(for: defaultCoordinate)
        })
        present(alert, animated: true)
    }
}



