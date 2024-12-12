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
            // Fetch request 생성
            let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
            
            // 정렬 기준 추가: 이름 오름차순
            let sortDescriptor = NSSortDescriptor(key: PhoneBook.Key.name, ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let phoneBooks = try self.container.viewContext.fetch(fetchRequest)
            phoneBooksArray = phoneBooks
            
        } catch {
            print("데이터 읽기 실패")
        }
        
        return phoneBooksArray
    }
    
    func updateData(currentName: String, updateName: String) {

        // 수정할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName) // 예시: 이름이 "Adam"인 데이터 수정
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                // 데이터 수정
                data.setValue(updateName, forKey: PhoneBook.Key.name) // 이름을 "Adam"에서 "Abel"로 수정
                
                // 변경 사항 저장
                try self.container.viewContext.save()
                print("데이터 수정 완료")
            }
            
        } catch {
            print("데이터 수정 실패")
        }
    }
    
    func deleteData(name: String) {
        // 삭제할 데이터를 찾기 위한 fetch request 생성
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            // fetch request 실행
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            // 결과 처리
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
                print("삭제된 데이터: \(data)")
            }
            
            // 변경 사항 저장
            try self.container.viewContext.save()
            print("데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }
    
    func deleteAllData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // Fetch 모든 엔티티를 가져옴
        let entities = appDelegate.persistentContainer.managedObjectModel.entities
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.name ?? "")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(deleteRequest)
                print("Entity \(entity.name ?? "") 데이터 삭제 성공!")
            } catch let error {
                print("Entity \(entity.name ?? "") 데이터 삭제 실패: \(error)")
            }
        }
    }
}
