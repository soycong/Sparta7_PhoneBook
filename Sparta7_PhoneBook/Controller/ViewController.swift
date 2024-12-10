//
//  ViewController.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/10/24.
//

import UIKit

class ViewController: UIViewController {
    private let mainTableView = MainTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = mainTableView
        
        navigationItem.title = "PocketMon"
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
    }
}

@available(iOS 17.0, *)
#Preview {
    ViewController()
}
