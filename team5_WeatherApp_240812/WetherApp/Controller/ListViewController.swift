//
//  ListViewController.swift
//  WetherApp
//
//  Created by t2023-m0112 on 8/12/24.
//

import UIKit
import CoreLocation

class ListViewController: UIViewController, UISearchBarDelegate {
    private let listView = ListView()
    private var currentWeather: CurrentWeatherResult?
    private let locationManager = LocationManager.shared
    private var weatherDataManager = WeatherDataManager.shared
    private var filteredLocations: [LocationResult] = []
    private var savedLocations: [SavedLocation] = []
    
    var isHiddenFlag: Bool = false
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupCollectionView()
        customNavigationBackButton()
        NotificationCenter.default.addObserver(self, selector: #selector(locationAdded), name: Notification.Name("LocationAdded"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedLocations()
    }
    
    private func loadSavedLocations() {
        savedLocations = SavedLocationManager.shared.getSavedLocations()
        listView.favoriteLocationCollectionView.reloadData()
    }
    
    @objc private func locationAdded() {
        loadSavedLocations()
    }
    
    private func customNavigationBackButton() {
        navigationController?.navigationBar.tintColor = .mainGreen
    }
    
    private func setupCollectionView() {
        listView.locationSearchCollectionView.dataSource = self
        listView.locationSearchCollectionView.delegate = self
        listView.locationSearchCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListView.cellIdentifier)
        listView.favoriteLocationCollectionView.dataSource = self
        listView.favoriteLocationCollectionView.delegate = self
        listView.favoriteLocationCollectionView.register(FavoriteLocationCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteLocationCollectionViewCell.id)
    }
    
    private func setupDelegates() {
        listView.searchBar.delegate = self

    }
    
    // MARK: - 서치바 Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLocations.removeAll()
            listView.locationSearchCollectionView.reloadData()
            listView.locationSearchCollectionView.isHidden = true
        } else {
            fetchLocations(for: searchText)
            listView.locationSearchCollectionView.isHidden = false
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        listView.locationSearchCollectionView.isHidden = false
    }
    
    // MARK: - 사용자가 입력한 검색어로 지역 목록을 가져오는 부분
    
    private func fetchLocations(for query: String) {
        NetworkManager.shared.fetchLocations(for: query) { [weak self] result in
            switch result {
            case .success(let locations):
                self?.filteredLocations = locations
                DispatchQueue.main.async {
                    self?.listView.locationSearchCollectionView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func fetchWeatherForLocation(lat: Double, lon: Double, locationName: String) {
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let addRegionViewController = AddRegionViewController()
            addRegionViewController.locationName = locationName
            addRegionViewController.coordinate = coordinate
            addRegionViewController.modalPresentationStyle = .pageSheet
            present(addRegionViewController, animated: true, completion: nil)
    }
    
    // MARK: - 선택된 지역의 날씨 정보 표시
    
    func presentAddRegionViewController(weatherData: CurrentWeatherResult, locationName: String, coordinate: CLLocationCoordinate2D) {
        let addRegionViewController = AddRegionViewController()
        currentWeather = weatherData
        addRegionViewController.locationName = locationName
        addRegionViewController.coordinate = coordinate
        addRegionViewController.modalPresentationStyle = .pageSheet
        present(addRegionViewController, animated: true, completion: nil)
    }
}


// MARK: - 이 컬렉션뷰는 검색창 컬렉션뷰임 Delegate, DataSource

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listView.locationSearchCollectionView {
            return filteredLocations.count
        } else if collectionView == listView.favoriteLocationCollectionView {
            return savedLocations.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == listView.locationSearchCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListView.cellIdentifier, for: indexPath) as? ListCollectionViewCell else {
                return UICollectionViewCell()
            }
            let location = filteredLocations[indexPath.row]
            cell.configure(with: location.formattedKoreanLocationName())
            return cell
        } else if collectionView == listView.favoriteLocationCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteLocationCollectionViewCell.id, for: indexPath) as? FavoriteLocationCollectionViewCell else {
                return UICollectionViewCell()
            }
            let location = savedLocations[indexPath.item]
            cell.configure(location)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listView.locationSearchCollectionView {
            let selectedLocation = filteredLocations[indexPath.row]
            fetchWeatherForLocation(lat: selectedLocation.lat, lon: selectedLocation.lon, locationName: "\(selectedLocation.name), \(selectedLocation.country)")
            listView.locationSearchCollectionView.isHidden = true
        } else if collectionView == listView.favoriteLocationCollectionView {
            let selectedLocation = savedLocations[indexPath.item]
            presentFavoriteModalViewController(for: selectedLocation)
        }
    }
    
    private func presentFavoriteModalViewController(for location: SavedLocation) {
        let favoriteModalVC = FavoriteModalViewController()
        favoriteModalVC.savedLocation = location
        favoriteModalVC.modalPresentationStyle = .pageSheet
        if let sheet = favoriteModalVC.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(favoriteModalVC, animated: true, completion: nil)
    }
}
