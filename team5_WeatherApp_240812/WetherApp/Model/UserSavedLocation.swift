//
//  UserSavedLocation.swift
//  WetherApp
//
//  Created by 임혜정 on 8/20/24.
//

import Foundation
import CoreLocation

// MARK: - 사용자 관심지역 저장, 관리

struct SavedLocation: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let temp: Double
    let description: String
}

class SavedLocationManager {
    static let shared = SavedLocationManager()
    
    private let userDefaults = UserDefaults.standard
    private let savedLocationKey = "SavedWeatherLocations"
    
    private init() {}
    
    func saveLocation(_ location: SavedLocation) {
        var savedLocations = getSavedLocations()
        savedLocations.append(location)
        
        if let encoded = try? JSONEncoder().encode(savedLocations) {
            userDefaults.set(encoded, forKey: savedLocationKey)
        }
    }
    
    func getSavedLocations() -> [SavedLocation] {
        if let savedData = userDefaults.data(forKey: savedLocationKey),
           let decodedLocations = try? JSONDecoder().decode( [SavedLocation].self, from: savedData) {
            return decodedLocations
        }
        return []
    }
    
    func updateLocation(_ location: SavedLocation, at index: Int) {
        var savedLocations = getSavedLocations()
        guard index < savedLocations.count else { return }
        
        savedLocations[index] = location
        
        if let encoded = try? JSONEncoder().encode(savedLocations) {
            userDefaults.set(encoded, forKey: savedLocationKey)
        }
        
    }
    
    func removeLocation(at index: Int) {
        var savedLocations = getSavedLocations()
        guard index < savedLocations.count else { return }
        
        savedLocations.remove(at: index)
        
        if let encoded = try? JSONEncoder().encode(savedLocations) {
            userDefaults.set(encoded, forKey: savedLocationKey)
        }
    }
    
}
