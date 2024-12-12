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
        loadData() // View가 Load 될 때마다 호출하여 데이터 갱신
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Pokemon Contacts"
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // 연락처 정보를 읽어옴
    func loadData() {
        let phoneBooks = phoneBookManager.readData()
        mainTableView.updateData(phoneBooks)
    }
    
    // 선택한 Cell의 Contact View로 이동
    func didSelectContact(_ contact: PhoneBook) {
        let contactAddViewController = ContactAddViewController()
        contactAddViewController.contact = contact
        contactAddViewController.mode = .edit
        navigationController?.pushViewController(contactAddViewController, animated: true)
    }
    
    // Contact 추가 화면으로 이동
    @objc private func addButtonTapped() {
        let contactAddViewController = ContactAddViewController()
        contactAddViewController.makeRandomPokemonImage()
        navigationController?.pushViewController(contactAddViewController, animated: true)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    ContactAddViewController()
//}
