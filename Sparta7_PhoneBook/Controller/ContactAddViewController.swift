//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
enum ContactMode {
    case add
    case edit
}

import UIKit
import CoreData
import Alamofire

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()
    let phoneBookManager = PhoneBookDataManager()
    var contact: PhoneBook?
    var mode: ContactMode = .add
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        configureNavigationBar()
        
        if mode == .edit {
            setContactData()
        }
    }
    
    // 상황에 따라 NavigationBar 설정
    func configureNavigationBar() {
        switch mode {
        case .add:
            navigationItem.title = "New Contact"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped)
            )
        case .edit:
            navigationItem.title = "Contact"
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped)
            )
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    func setContactData() {
        guard let contact = contact else { return }
        contactAddView.nameTextView.text = contact.name
        contactAddView.numberTextView.text = contact.number
        
        if let imageString = contact.profileImage {
            contactAddView.profileImageView.image = ImageConversionHelper.convertStringToImage(imageString)
        }
    }
    
    // 랜덤 이미지 형성
    func makeRandomPokemonImage() {
        PokemonImageService.fetchPokemonData { result in
            switch result {
            case .success(let pokemonImage):
                self.contactAddView.profileImageView.image = pokemonImage
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func handleSaveModeAndEditMode(isEditMode: Bool) {
        guard let name = contactAddView.nameTextView.text,
              let phoneNumber = contactAddView.numberTextView.text,
              let profileImage = contactAddView.profileImageView.image else {
            print("데이터가 비어 있습니다.")
            return
        }
        
        let pokemonImageString = ImageConversionHelper.convertImageToString(profileImage) ?? ""

        if isEditMode { // edit일 경우 data upadte
            phoneBookManager.updateData(currentName: contact?.name ?? "", updateName: name, updateNumber: phoneNumber, updateProfileImage: pokemonImageString)
        } else {  //add일 경우 data create
            phoneBookManager.createData(name: name, phoneNumber: phoneNumber, profileImageURL: pokemonImageString)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        handleSaveModeAndEditMode(isEditMode: false)
    }
    
    @objc func editButtonTapped() {
        handleSaveModeAndEditMode(isEditMode: true)
    }
    
    @objc func randomChangeButtonTapped(_ sender: UIButton) {
        makeRandomPokemonImage()
    }
}
