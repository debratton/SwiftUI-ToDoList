//
//  AddCategoryViewModel.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import Foundation
import SwiftUI

class AddCategoryViewModel {
    var id: String = UUID().uuidString
    var createdAt: Date = Date()
    var dueDate: Date = Date()
    var dueTime: Date = Date()
    var isComplete: Bool = false
    var isImportant: Bool = false
    var name: String = ""
    
    func saveCategory() {
        CoreDataManager.shared.saveCategory(id: self.id, createdAt: self.createdAt, dueDate: self.dueDate, dueTime: self.dueTime, isComplete: self.isComplete, isImportant: self.isImportant, name: self.name)
    }
}
