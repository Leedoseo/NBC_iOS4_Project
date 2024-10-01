//
//  LocationManager.swift
//  WetherApp
//
//  Created by 임혜정 on 8/17/24.
//

import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation)
    func locationManager(_ manager: LocationManager, didFailWithError error: Error)
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let clLocationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    private override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        clLocationManager.delegate = self
        clLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocationAuthorization() {
        clLocationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        clLocationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        clLocationManager.stopUpdatingLocation()
    }
    
    func requestCurrentLocation() {
        clLocationManager.requestLocation()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.locationManager(self, didUpdateLocation: location)
        stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationManager(self, didFailWithError: error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            delegate?.locationManager(self, didFailWithError: NSError(domain: "LocationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Location access denied"]))
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
}
