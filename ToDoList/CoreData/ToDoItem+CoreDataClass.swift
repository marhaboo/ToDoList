//
//  ToDoItem+CoreDataClass.swift
//  ToDoList
//
//  Created by Boynurodova Marhabo on 09/11/25.
//
//

public import Foundation
public import CoreData

public typealias ToDoItemCoreDataClassSet = NSSet

@objc(ToDoItem)
public class ToDoItem: NSManagedObject {
    public override var description: String {
        let title = title ?? "No task"
        let isDone = isDone
        return "The task is \(title), the status is \(isDone ? "Completed" : "Incompleted")"
    }

}
