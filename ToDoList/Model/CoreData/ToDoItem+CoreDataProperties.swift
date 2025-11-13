//
//  ToDoItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 09/11/25.
//
//


public import CoreData

public extension ToDoItem {

    @nonobjc  class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged  var isDone: Bool
    @NSManaged  var title: String?

}

extension ToDoItem : Identifiable { }
