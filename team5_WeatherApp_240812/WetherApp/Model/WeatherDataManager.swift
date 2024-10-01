//
//  WeatherDataManager.swift
//  WetherApp
//
//  Created by 임혜정 on 8/18/24.
//

import Foundation
import CoreLocation

class WeatherDataManager {
    static let shared = WeatherDataManager()
    private let formatter = WeatherDataFormatter.shared
    
    private init() {}
    
    func formatWeatherData(_ currentWeather: CurrentWeatherResult) -> (description: String, temp: Int, minTemp: Int, maxTemp: Int) {
        let temp = Int(currentWeather.main.temp)
        let weatherDescription = currentWeather.weather.first?.main ?? ""
        let minTemp = Int(currentWeather.main.temp_min)
        let maxTemp = Int(currentWeather.main.temp_max)
        return (weatherDescription, temp, minTemp, maxTemp)
    }

    func getLocationName(from location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            let locationName = placemarks?.first?.locality ?? placemarks?.first?.administrativeArea ?? "현재 위치"
            completion(locationName)
        }
    }
}
