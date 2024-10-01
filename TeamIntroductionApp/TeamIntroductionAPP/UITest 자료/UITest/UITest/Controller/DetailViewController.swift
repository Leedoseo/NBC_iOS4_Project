//
//  DetailViewController.swift
//  UITest
//
//  Created by 박승환 on 5/27/24.
//

import UIKit
import SafariServices

protocol EditViewControllerDelegate: AnyObject {
    func didSaveInfo(_ info: Info)
}

class DetailViewController: UIViewController, EditViewControllerDelegate {
    
    var info: Info?
    weak var delegate: EditViewControllerDelegate?
    
    // 프로필 사진
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        
        setupImageView()
        setupInfoStackView()
    }
    
    @objc func editButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editVC = storyboard.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
            editVC.info = self.info
            editVC.delegate = self
            navigationController?.pushViewController(editVC, animated: true)
        }
    }
    
    func didSaveInfo(_ info: Info) {
        self.info = info
        delegate?.didSaveInfo(info)
        setupImageView()
        setupInfoStackView()
    }
    
    func setupImageView() {
        let information = Information.shared
        // imageView 셋팅
        if let name = info?.name, let imageName = information.images[name], let image = UIImage(named: imageName) {
            imageView.image = image
        } else {
            imageView.image = nil
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // imageView 위치 조정
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupInfoStackView() {
        view.subviews.forEach { if $0 is UIStackView { $0.removeFromSuperview() } }
        // stackView 생성 및 세팅
        let stackView = createInfoStackView()
        // 화면에 stackView 추가
        view.addSubview(stackView)
        // stackView 위치 조정
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    // 정보를 나타내는 stackView 생성 함수
    func createInfoStackView() -> UIStackView {
        // 기본 셋팅
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        // stackView 안에 들어갈 lable, button 생성
        let nameLable = createLable("name")
        let ageLabel = createLable("age")
        let areaLable = createLable("area")
        let MBTILable = createLable("MBTI")
        let positionLabel = createLable("position")
        let introduceLabel = createLable("introduce")
        let buttonStackView = createButtonStackView()
        
        stackView.addArrangedSubview(nameLable)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(areaLable)
        stackView.addArrangedSubview(MBTILable)
        stackView.addArrangedSubview(positionLabel)
        stackView.addArrangedSubview(introduceLabel)
        stackView.addArrangedSubview(buttonStackView)
        
        return stackView
    }
    
    // 버튼을 정렬할 stackView 생성
    func createButtonStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        // 버튼 추가
        let gitButton = createButton("git")
        let blogButton = createButton("blog")
        
        stackView.addArrangedSubview(gitButton)
        stackView.addArrangedSubview(blogButton)
        
        return stackView
    }
    
    // 버튼 추가
    func createButton(_ platform: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        // 이동할 버튼에 따라 text 변경
        switch(platform) {
        case "git":
            button.setTitle("깃허브", for: .normal)
            button.tag = 1
        case "blog":
            button.setTitle("블로그", for: .normal)
            button.tag = 2
        default:
            button.setTitle("nil", for: .normal)
        }
        // 버튼을 클릭했을 때 작동할 함수 설정
        button.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
        return button
    }
    
    // 정보를 저장할 label 을 만드는 함수
    func createLable(_ type: String) -> UILabel {
        let label = UILabel()
        // label 타입에 따라 다르게 지정
        switch(type) {
        case "name":
            if let name = info?.name {
                label.text = "이름 : \(name)"
            }
        case "age":
            if let age = info?.age {
                label.text = "나이 : \(age)"
            }
        case "area":
            if let area = info?.area {
                label.text = "사는 곳 : \(area)"
            }
        case "MBTI":
            if let mbti = info?.MBTI {
                label.text = "MBTI : \(mbti)"
            }
        case "position":
            if let position = info?.position {
                label.text = "역할 : \(position)"
            }
        case "introduce":
            if let introduce = info?.introduce {
                label.text = "자기소개 : \(introduce)"
            }
        default:
            label.text = "nil"
        }
        label.textAlignment = .center
        
        return label
    }
    
    // 버튼을 클릭했을 때 실행할 함수
    @objc func didTabButton(_ sender: UIButton) {
        let buttonTag = sender.tag
        switch(buttonTag) {
        case 1:
            let url = info?.gitHubURL
            goToPlatform(url!)
        case 2:
            let url = info?.blogURL
            goToPlatform(url!)
        default:
            return
        }
    }
    
    // 인터넷 브라우저로 연결하기 위한 함수
    func goToPlatform(_ url: String) {
        let url = URL(string: url)
        let safariViewController = SFSafariViewController(url: url!)
        present(safariViewController, animated: true)
    }
}
