//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit
import Alamofire
import CoreData

class ViewController: UIViewController, MainTableViewDelegate {
    private let mainTableView = MainTableView()
    let phoneBookManager = PhoneBookDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainTableView
        
        mainTableView.delegate = self
        
        //phoneBookManager.deleteAllData()
        configureNavigationBar()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Pokemon Contacts"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func loadData() {
        let phoneBooks = phoneBookManager.readData()
        mainTableView.updateData(phoneBooks)
    }
    
    @objc private func addButtonTapped() {
        let contactAddViewController = ContactAddViewController()
        contactAddViewController.makeRandomPokemonImage()
        navigationController?.pushViewController(contactAddViewController, animated: true)
    }
    
    // MARK: MainTableViewDelegate
    func didSelectContact(_ contact: PhoneBook) {
        let contactAddViewController = ContactAddViewController()
        contactAddViewController.contact = contact
        contactAddViewController.mode = .edit
        navigationController?.pushViewController(contactAddViewController, animated: true)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ContactAddViewController()
//}
