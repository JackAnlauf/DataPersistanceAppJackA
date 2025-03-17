//
//  ToDoItem+CoreDataProperties.swift
//  DataPersistanceAppJackA
//
//  Created by student on 3/11/25.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var about: String?
    @NSManaged public var status: Bool

}

extension ToDoItem : Identifiable {

}
