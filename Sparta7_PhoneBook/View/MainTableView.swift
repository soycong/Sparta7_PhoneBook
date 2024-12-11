//
//  MainTableView.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import SnapKit

class MainTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    
    var phoneBookData: [PhoneBook] = [] // PhoneBook 데이터 배열
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PokeMon"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var names: [String] = []
    var numbers: [String] = []
    var imageURLs: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        configureTableView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            //make.top.equalTo(titleLabel.snp.bottom)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    func updateData(_ data: [PhoneBook]) {
        self.phoneBookData = data
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        
        let phoneBook = phoneBookData[indexPath.row]
        
        cell.nameLabel.text = phoneBook.name
        cell.numberLabel.text = phoneBook.number
        
        if let profileImageString = phoneBook.profileImage,
           let url = URL(string: profileImageString),
           let imageData = try? Data(contentsOf: url),
           let downloadedImage = UIImage(data: imageData) {
            cell.profileImageView.image = downloadedImage
        } else {
            cell.profileImageView.image = UIImage(named: "ProfileImage") // 기본 이미지 설정
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
