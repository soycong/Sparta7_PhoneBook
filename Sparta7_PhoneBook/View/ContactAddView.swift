//
//  ContactAddView.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import SnapKit

class ContactAddView: UIView {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "ProfileImage")
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemCyan.cgColor
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let randomImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random Image", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Name"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 15)
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true

        return textView
    }()
    
    let numberTextView: UITextView = {
        let textView = UITextView()
        textView.text = "PhoneNumber"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 15)
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        
        return textView
    }()
    
    private lazy var stackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, randomImageButton, nameTextView, numberTextView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        let profileImageSize: CGFloat = 120
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        profileImageView.layer.cornerRadius = profileImageSize/2
        profileImageView.layer.masksToBounds = true
        
        randomImageButton.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        randomImageButton.addTarget(UIViewController(), action: #selector(ContactAddViewController.randomChangeButtonTapped(_:)), for: .touchUpInside)

        
        nameTextView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        numberTextView.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(30)
        }
    }
}
