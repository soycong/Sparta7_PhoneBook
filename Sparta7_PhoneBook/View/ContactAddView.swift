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
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let randomImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random Image", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Name"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 12)
        
        textView.layer.borderColor = UIColor.gray.cgColor  // 테두리 색상
        textView.layer.borderWidth = 1  // 테두리 두께
        textView.layer.cornerRadius = 8  // 테두리 둥글기
        textView.clipsToBounds = true  // 테두리가 둥글게 잘리도록 설정

        return textView
    }()
    
    let numberTextView: UITextView = {
        let textView = UITextView()
        textView.text = "PhoneNumber"
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 12)
        
        textView.layer.borderColor = UIColor.gray.cgColor  // 테두리 색상
        textView.layer.borderWidth = 1  // 테두리 두께
        textView.layer.cornerRadius = 8  // 테두리 둥글기
        textView.clipsToBounds = true  // 테두리가 둥글게 잘리도록 설정
        
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
            //make.edges.equalTo(self.safeAreaLayoutGuide).inset(20) // 전체 여백 20
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            //make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 중앙 정렬
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            //make.width.equalToSuperview().multipliedBy(0.3) // 부모 뷰 너비의 30%
            make.width.equalTo(profileImageSize)
            make.height.equalTo(profileImageView.snp.width) // 1:1 비율
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
