import UIKit
import SnapKit

class FriendListViewLabel: UIView {
    let titleLabel = UILabel() // 친구 목록 레이블
    let addButton = UIButton() // 추가 버튼
    let tableView = UITableView() // 테이블 뷰

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI() // UI 설정 메서드 호출
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white 

        // 친구 목록 레이블 설정
        titleLabel.text = "친구 목록"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(titleLabel)

        // 추가 버튼 설정
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.lightGray, for: .normal)
        addButton.backgroundColor = .clear
        addSubview(addButton)

        // 테이블 뷰 추가
        addSubview(tableView)

        // 제약조건 설정
        setupConstraints()
    }

    private func setupConstraints() {
        // 친구 목록 레이블 제약조건
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(0)
            $0.centerX.equalToSuperview()
        }

        // 추가 버튼 제약조건
        addButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-16) //
            $0.centerY.equalTo(titleLabel)
            $0.height.equalTo(50)
            $0.width.equalTo(80)
        }

        // 테이블 뷰 제약조건
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview() 
        }
    }
}
