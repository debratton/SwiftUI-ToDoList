//
//  CategoryListViewModel.swift
//  ToDoList
//
//  Created by David E Bratton on 3/30/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class CategoryListViewModel: ObservableObject {
    
    @Published var categories = [CategoryViewModel]()
    
    init(complete: String) {
        fetchCategoriesFiltered(searchString: "", complete: complete)
    }
    
    func fetchCategoriesFiltered(searchString: String, complete: String) {
        self.categories = CoreDataManager.shared.fetchCategoriesFiltered(searchString: searchString, complete: complete).map(CategoryViewModel.init)
        print("DEBUG: Category fetch results for string \(searchString): \(self.categories.count)")
    }
    
    func addCategory(id: String, dueDate: Date, isComplete: Bool, isImportant: Bool, name: String) {
        CoreDataManager.shared.saveCategory(id: id, createdAt: Date(), dueDate: dueDate, isComplete: isComplete, isImportant: isImportant, name: name)
        fetchCategoriesFiltered(searchString: "", complete: "NO")
    }
    
    func deleteCategory(_ categoryVM: CategoryViewModel, complete: String) {
        CoreDataManager.shared.deleteCategory(id: categoryVM.id)
        fetchCategoriesFiltered(searchString: "", complete: complete)
    }
    
    func completeCategory(_ categoryVM: CategoryViewModel, complete: String) {
        CoreDataManager.shared.completeCategory(id: categoryVM.id)
        fetchCategoriesFiltered(searchString: "", complete: complete)
    }
    
    func updateCategory(id: String, dueDate: Date, isComplete: Bool, isImportant: Bool, name: String) {
        CoreDataManager.shared.updateCategory(id: id, dueDate: dueDate, isComplete: isComplete, isImportant: isImportant, name: name)
        fetchCategoriesFiltered(searchString: "", complete: "")
    }
}

class CategoryViewModel {
    var id: String = ""
    var createdAt: Date
    var dueDate: Date
    var isComplete: Bool
    var isImportant: Bool
    var name: String = ""
    
    init(category: Category) {
        self.id = category.id!
        self.createdAt = category.createdAt!
        self.dueDate = category.dueDate!
        self.isComplete = category.isComplete
        self.isImportant = category.isImportant
        self.name = category.name!
    }
}
