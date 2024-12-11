//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController {
    private let mainTableView = MainTableView()
    
    var container: NSPersistentContainer!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainTableView
        
        navigationItem.title = "Pokemon"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
        readAllData()
    }
    
    @objc private func addButtonTapped() {
        // 이 부분 수정하기
//        let contactAddViewController = ContactAddViewController()
//        navigationController?.pushViewController(contactAddViewController, animated: true)
        readAllData()
        
        makeRandomPokemonImage()
    }
    
    func makeRandomPokemonImage() {
        var randomNumber = Int.random(in: (1...1000))
        
        PokemonImageService.fetchPokemonData(pokemonID: randomNumber) { [weak self] (result: Result<PokemonImageModel, Error>) in
            switch result {
            case .success(let pokemon):
                let contactAddViewController = ContactAddViewController()
                contactAddViewController.pokemon = pokemon // 전달
                self?.navigationController?.pushViewController(contactAddViewController, animated: true)
                
            case .failure(let error):
                print("Error fetching Pokémon data: \(error.localizedDescription)")
            }
        }
    }
    
    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            
            //url string말고 URL타입으로 전달 가능?
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.number) as? String,
                   let profileImageURL = phoneBook.value(forKey: PhoneBook.Key.profileImage) as? String {
                    print("name: \(name), phoneNumber: \(phoneNumber), profileImageURL: \(profileImageURL)")
                    
                    mainTableView.names.append(name)
                    mainTableView.numbers.append(phoneNumber)
                    mainTableView.imageURLs.append(profileImageURL)
                    
                    //                let contactAddViewController = ContactAddViewController()
                    //                contactAddViewController.pokemon = pokemon // 전달
                    //self?.navigationController?.pushViewController(contactAddViewController, animated: true)
                    
                    //                DispatchQueue.main.async {
                    //                    self?.contactAddView.profileImageView.reloadData()
                    //                }
                }
            }
        } catch {
            print("데이터 읽기 실패")
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ContactAddViewController()
//}
