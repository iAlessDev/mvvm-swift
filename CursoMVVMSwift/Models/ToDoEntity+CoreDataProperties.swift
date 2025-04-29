//
//  ToDoEntity+CoreDataProperties.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 22/04/25.
//
//

import Foundation
import CoreData


extension ToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
    }

    @NSManaged public var isArchived: Bool
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: Date?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var id: String

}

extension ToDoEntity : Identifiable {

}
