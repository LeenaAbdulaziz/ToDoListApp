//
//  ToDoItem+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Linah abdulaziz on 15/05/1443 AH.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var checkMark: Bool
    @NSManaged public var date: Date?
    @NSManaged public var details: String?
    @NSManaged public var titel: String?

}

extension ToDoItem : Identifiable {

}
