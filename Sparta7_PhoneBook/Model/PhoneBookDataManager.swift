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
    
    // 데이터 생성
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
    
    // 데이터 읽기
    func readData() -> [PhoneBook] {
        var phoneBooksArray: [PhoneBook] = []
        
        do {
            let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
            
            let sortDescriptor = NSSortDescriptor(key: PhoneBook.Key.name, ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let phoneBooks = try self.container.viewContext.fetch(fetchRequest)
            phoneBooksArray = phoneBooks
            
        } catch {
            print("데이터 읽기 실패")
        }
        
        return phoneBooksArray
    }
    
    // 데이터 업데이트
    func updateData(currentName: String, updateName: String, updateNumber: String, updateProfileImage: String) {

        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                data.setValue(updateName, forKey: PhoneBook.Key.name)
                data.setValue(updateNumber, forKey: PhoneBook.Key.number)
                data.setValue(updateProfileImage, forKey: PhoneBook.Key.profileImage)
                
                try self.container.viewContext.save()
                print("데이터 수정 완료")
            }
            
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    // 데이터 단일 삭제
    func deleteData(name: String) {
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
                print("삭제된 데이터: \(data)")
            }
            
            try self.container.viewContext.save()
            print("데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }
    
    // 데이터 전체 삭제
    func deleteAllData() {
        let context = self.container.viewContext
        
        let entities = self.container.managedObjectModel.entities.filter { entity in
            return entity.name == "PhoneBook"
        }
        
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name ?? "")
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                print("Entity \(entity.name ?? "") 데이터 삭제 성공!")
            } catch let error {
                print("Entity \(entity.name ?? "") 데이터 삭제 실패: \(error.localizedDescription)")
            }
        }
    }
}
