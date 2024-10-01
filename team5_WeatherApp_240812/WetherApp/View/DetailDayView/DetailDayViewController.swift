//
//  DetailDayViewController.swift
//  WetherApp
//
//  Created by 유민우 on 8/12/24.
//

import UIKit
import SnapKit

class DetailDayViewController: UIViewController {
    
    // MARK: - Property
    
    private var weatherData: CurrentWeatherResult?
    private var weatherIcon: UIImage?
    private var locationName: String?
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "(검색된) 위치"
        label.textColor = .mainGreen
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    lazy var detailDayCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherDetailCollectionViewCell.self, forCellWithReuseIdentifier: WeatherDetailCollectionViewCell.id)
        collectionView.register(DetailDaySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailDaySectionHeaderView.id)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init(weatherData: CurrentWeatherResult?, locationName: String?) {
        self.weatherData = weatherData
        self.locationName = locationName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchWeatherData()
    }
    
    //MARK: - Method
    
    private func fetchWeatherData() {
//        guard let weatherData = weatherData else {
//            print("Weather data is not available")
//            return
//        }
        DispatchQueue.main.async {
            self.detailDayCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .mainDarkGray
        [locationLabel, detailDayCollectionView].forEach { view.addSubview($0) }
        
        locationLabel.text = locationName ?? "(검색된) 위치"
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(20)
        }
        
        detailDayCollectionView.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.createWeaterDetailSectionLayout()
        }
    }
    
    private func createWeaterDetailSectionLayout() -> NSCollectionLayoutSection {
        // 아이템 설정
        // 첫 번째 아이템(병합된 셀) 설정
        let fullWidthItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let fullWidthItem = NSCollectionLayoutItem(layoutSize: fullWidthItemSize)
        
        // 두 번째 아이템 설정
        let halfWidthItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let halfWidthItem = NSCollectionLayoutItem(layoutSize: halfWidthItemSize)
        
        // 수평 그룹(두 개의 셀을 나란히 배치) 설정
        let halfWidthGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let halfWidthGroup = NSCollectionLayoutGroup.horizontal(layoutSize: halfWidthGroupSize, subitem: halfWidthItem, count: 2)
        halfWidthGroup.interItemSpacing = .fixed(10)
        
        // 최종 수직 그룹 설정 (병합된 셀 + 두 개의 셀)
        let finalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(450))
        let finalGroup = NSCollectionLayoutGroup.vertical(layoutSize: finalGroupSize, subitems: [fullWidthItem, halfWidthGroup])
        finalGroup.interItemSpacing = .fixed(10)
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: finalGroup)
        section.interGroupSpacing = 10
        
        // 헤더 추가
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

// MARK: - Extension

extension DetailDayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData != nil ? 6 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailCollectionViewCell.id, for: indexPath) as? WeatherDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let weatherData = weatherData {
            let formtter = WeatherDataFormatter.shared
            print("Configuring cell for item: \(indexPath.item) with data: \(weatherData)")
            cell.configure(for: indexPath.item, with: weatherData, formatter: formtter)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("error")
        }
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailDaySectionHeaderView.id, for: indexPath) as? DetailDaySectionHeaderView else {
            return UICollectionReusableView()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        let todayDate = dateFormatter.string(from: Date())
    
        headerView.configure(with: todayDate)
        return headerView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
        
}
