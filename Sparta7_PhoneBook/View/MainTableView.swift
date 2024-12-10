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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        // SnapKit으로 제약 조건 설정
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.top)
            make.trailing.equalTo(self.snp.top)
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
}
