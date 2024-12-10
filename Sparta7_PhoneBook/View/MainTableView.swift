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
        //        self.addSubview(titleLabel)
        //        titleLabel.snp.makeConstraints { make in
        //            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
        //            make.centerX.equalToSuperview()
        //            make.width.equalTo(200)
        //        }
        //        
        //        self.addSubview(addButton)
        //        addButton.snp.makeConstraints { make in
        //            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
        //            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(10)
        //        }
        // SnapKit으로 제약 조건 설정
        tableView.snp.makeConstraints { make in
            //make.top.equalTo(titleLabel.snp.bottom)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Set this to the desired height
    }
}
