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
        //imageView.image = UIImage(named: "ProfileImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        //label.text = "Name"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        //label.text = "PhoneNumber"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var verticalStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, numberLabel])
        stackView.axis = .vertical
        //stackView.spacing = 20
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var horizontalStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, verticalStackView])
        stackView.axis = .horizontal
        //stackView.spacing = 20
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
        let profileImageSize: CGFloat = 70
        
        addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            //make.edges.equalTo(self.safeAreaLayoutGuide).inset(20) // 전체 여백 20
            make.centerY.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        verticalStackView.snp.makeConstraints { make in
            //make.edges.equalTo(self.safeAreaLayoutGuide).inset(20) // 전체 여백 20
            make.centerY.equalTo(profileImageView)

//            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
//            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
//            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
//            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        profileImageView.snp.makeConstraints { make in
           // make.centerY.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageView.snp.width) // 1:1 비율
        }
        
        profileImageView.layer.cornerRadius = profileImageSize/2
        profileImageView.layer.masksToBounds = true

        nameLabel.snp.makeConstraints { make in
            //make.height.equalTo(35)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        numberLabel.snp.makeConstraints { make in
            //make.height.equalTo(35)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
}
