//
//  ContactAddViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//
import UIKit
import CoreData
import Alamofire

class ContactAddViewController: UIViewController {
    private let contactAddView = ContactAddView()
    let phoneBookManager = PhoneBookDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contactAddView
        
        configureNavigationBar()
    }

    func configureNavigationBar() {
        navigationItem.title = "New Contact"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
    }

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
    
    func convertImageToString(_ image: UIImage) -> String {
        guard let data = image.pngData() else { return ("convertImageToString fail") }
        
        return data.base64EncodedString()
    }

    @objc private func saveButtonTapped() {
        guard let name = contactAddView.nameTextView.text,
              let phoneNumber = contactAddView.numberTextView.text,
              let profileImage = contactAddView.profileImageView.image else {
            print("데이터가 비어 있습니다.")
            return
        }
        
        let pokemonImageString = convertImageToString(profileImage)
        
        phoneBookManager.createData(name: name, phoneNumber: phoneNumber, profileImageURL: pokemonImageString)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func randomChangeButtonTapped(_ sender: UIButton) {
        makeRandomPokemonImage()
    }
}
