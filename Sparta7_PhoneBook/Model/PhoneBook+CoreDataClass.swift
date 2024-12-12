//
//  PhoneBook+CoreDataClass.swift
//  Sparta7_PhoneBook
//
//  Created by seohuibaek on 12/11/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let number = "number"
        static let profileImage = "profileImage"
    }
}
