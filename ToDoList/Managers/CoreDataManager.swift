//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // Create shared singleton to share
    static let shared = CoreDataManager(moc: NSManagedObjectContext.current)
    
    var moc: NSManagedObjectContext
    
    private init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func saveCategory(id: String, createdAt: Date, dueDate: Date, dueTime: Date, isComplete: Bool, isImportant: Bool, name: String) {
        let category = Category(context: self.moc)
        category.id = id
        category.createdAt = createdAt
        category.dueDate = dueDate
        category.dueTime = dueTime
        category.isComplete = isComplete
        category.isImportant = isImportant
        category.name = name
        
        do {
            try self.moc.save()
        } catch {
            print("Error saving category with error: \(error.localizedDescription)")
        }
    }
}
