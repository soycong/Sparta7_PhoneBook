//
//  PhoneBookDataManager.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/11/24.
//
import UIKit
import CoreData

class PhoneBookDataManager {
    var container: NSPersistentContainer!
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    func createData(name: String, phoneNumber: String, profileImageURL: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.number)
        newPhoneBook.setValue(profileImageURL, forKey: PhoneBook.Key.profileImage)
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    func readData() -> [PhoneBook] {
        var phoneBooksArray: [PhoneBook] = []
        
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            phoneBooksArray = phoneBooks
            
        } catch {
            print("데이터 읽기 실패")
        }
        
        return phoneBooksArray
    }
}
