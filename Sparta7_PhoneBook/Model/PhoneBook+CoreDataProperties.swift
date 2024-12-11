//
//  PhoneBook+CoreDataProperties.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/11/24.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var profileImage: String?

}

extension PhoneBook : Identifiable {

}
