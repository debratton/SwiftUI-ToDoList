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
    
    // MARK: - Category Fetch
    func fetchAllCategories() -> [Category] {
        var fetchCategories = [Category]()
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let sortByCreatDate = NSSortDescriptor(key: "createdAt", ascending: false)
        let sortDescriptors = [sortByCreatDate]
        request.sortDescriptors = sortDescriptors
        do {
            fetchCategories = try moc.fetch(request)
        } catch {
            print("Error fetching categories \(error.localizedDescription)")
        }
        return fetchCategories
    }
    
    func fetchCategory(id: String) -> Category? {
        var fetchCategories = [Category]()
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            fetchCategories = try moc.fetch(request)
        } catch {
            print("Error fetching category to delete \(error.localizedDescription)")
        }
        return fetchCategories.first
    }
    
    func fetchCategoriesFiltered(searchString: String, complete: String) -> [Category] {
        if searchString != "" {
            var fetchCategories = [Category]()
            let request: NSFetchRequest<Category> = Category.fetchRequest()
            let predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchString)
            let sortDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
            let sortDueTime = NSSortDescriptor(key: "dueTime", ascending: false)
            let sortDescriptors = [sortDueDate, sortDueTime]
            request.sortDescriptors = sortDescriptors
            request.predicate = predicate
            do {
                fetchCategories = try moc.fetch(request)
            } catch {
                print("Error fetching categories \(error.localizedDescription)")
            }
            return fetchCategories
        } else {
            switch complete {
            case "NO":
                var fetchCategories = [Category]()
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                let predicate = NSPredicate(format: "isComplete == 0")
                let sortDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
                let sortDueTime = NSSortDescriptor(key: "dueTime", ascending: false)
                let sortDescriptors = [sortDueDate, sortDueTime]
                request.sortDescriptors = sortDescriptors
                request.predicate = predicate
                do {
                    fetchCategories = try moc.fetch(request)
                } catch {
                    print("Error fetching categories \(error.localizedDescription)")
                }
                return fetchCategories
            case "YES":
                var fetchCategories = [Category]()
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                let predicate = NSPredicate(format: "isComplete == 1")
                let sortDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
                let sortDueTime = NSSortDescriptor(key: "dueTime", ascending: false)
                let sortDescriptors = [sortDueDate, sortDueTime]
                request.sortDescriptors = sortDescriptors
                request.predicate = predicate
                do {
                    fetchCategories = try moc.fetch(request)
                } catch {
                    print("Error fetching categories \(error.localizedDescription)")
                }
                return fetchCategories
            case "ALL":
                var fetchCategories = [Category]()
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                let predicate = NSPredicate(format: "isComplete == 0 || isComplete == 1")
                let sortDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
                let sortDueTime = NSSortDescriptor(key: "dueTime", ascending: false)
                let sortDescriptors = [sortDueDate, sortDueTime]
                request.sortDescriptors = sortDescriptors
                request.predicate = predicate
                do {
                    fetchCategories = try moc.fetch(request)
                } catch {
                    print("Error fetching categories \(error.localizedDescription)")
                }
                return fetchCategories
            default:
                var fetchCategories = [Category]()
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                let predicate = NSPredicate(format: "isComplete == 0")
                let sortDueDate = NSSortDescriptor(key: "dueDate", ascending: true)
                let sortDueTime = NSSortDescriptor(key: "dueTime", ascending: false)
                let sortDescriptors = [sortDueDate, sortDueTime]
                request.sortDescriptors = sortDescriptors
                request.predicate = predicate
                do {
                    fetchCategories = try moc.fetch(request)
                } catch {
                    print("Error fetching categories \(error.localizedDescription)")
                }
                return fetchCategories
            }
        }
    }
    
    // MARK: - Category Save
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
    
    // MARK: - Category Complete
    func completeCategory(id: String) {
        if let category = fetchCategory(id: id) {
            category.isComplete.toggle()
            do {
                try self.moc.save()
            } catch {
                print("Error completing category \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Category Update
    func updateCategory(id: String, dueDate: Date, dueTime: Date, isComplete: Bool, isImportant: Bool, name: String) {
        if let category = fetchCategory(id: id) {
            category.dueDate = dueDate
            category.dueTime = dueTime
            category.isComplete = isComplete
            category.isImportant = isImportant
            category.name = name
            do {
                try self.moc.save()
            } catch {
                print("Error completing category \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Category Delete
    func deleteCategory(id: String) {
        if let category = fetchCategory(id: id) {
            self.moc.delete(category)
            do {
                try self.moc.save()
            } catch {
                print("Error deleting category \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Item Fetch
    func fetchAllItems(passedCatId: String) -> [Item] {
        var fetchItems = [Item]()
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "category.id == %@", passedCatId)
        let sortByCreatDate = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptors = [sortByCreatDate]
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        do {
            fetchItems = try moc.fetch(request)
        } catch {
            print("Error fetching items \(error.localizedDescription)")
        }
        return fetchItems
    }
    
    func fetchItem(id: String) -> Item? {
        var fetchItems = [Item]()
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            fetchItems = try moc.fetch(request)
        } catch {
            print("Error fetching category to delete \(error.localizedDescription)")
        }
        return fetchItems.first
    }
    
    // MARK: - Item Process and Save
    func processItem(id: String, isComplete: Bool, name: String, passedCatId: String) {
        let item = Item(context: self.moc)
        item.id = id
        item.isComplete = isComplete
        item.name = name
        
        saveItem(passedCatId: passedCatId, item: item)
    }
    
    func saveItem(passedCatId: String, item: Item) {
        if let fetchedCategory = fetchCategory(id: passedCatId) {
            item.category = fetchedCategory
            do {
                try self.moc.save()
            } catch {
                print("Error saving Item \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Category Delete
    func deleteItem(id: String) {
        if let item = fetchItem(id: id) {
            self.moc.delete(item)
            do {
                try self.moc.save()
            } catch {
                print("Error deleting item \(error.localizedDescription)")
            }
        }
    }
}
