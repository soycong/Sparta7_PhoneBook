//
//  MainTableViewCell.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemCyan.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, nameLabel, numberLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        let profileImageSize: CGFloat = 60
        
        addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        profileImageView.layer.cornerRadius = profileImageSize/2
        profileImageView.layer.masksToBounds = true
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(profileImageView.snp.width)
        }
    }
}
