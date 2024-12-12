//
//  MainTableView.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import SnapKit

protocol MainTableViewDelegate: AnyObject {
    func didSelectContact(_ contact: PhoneBook)
}

class MainTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: MainTableViewDelegate?
    
    let tableView = UITableView()
    
    var phoneBookData: [PhoneBook] = []

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedContact = phoneBookData[indexPath.row]
        delegate?.didSelectContact(selectedContact)
        tableView.deselectRow(at: indexPath, animated: true)
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
        cell.profileImageView.image = ImageConversionHelper.convertStringToImage(phoneBook.profileImage)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
