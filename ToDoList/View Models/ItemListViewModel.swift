//
//  ItemListViewModel.swift
//  ToDoList
//
//  Created by David E Bratton on 4/4/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData
import Combine

class ItemListViewModel: ObservableObject {

    @Published var items = [ItemViewModel]()
    
    init(passedCatId: String) {
        fetchItems(passedCatId: passedCatId)
    }
    
    func fetchItems(passedCatId: String) {
        self.items = CoreDataManager.shared.fetchAllItems(passedCatId: passedCatId).map(ItemViewModel.init)
        print("DEBUG: Item fetch results for: \(self.items.count)")
    }
    
    func fetchItemsCount(passedCatId: String) -> String {
        self.items = CoreDataManager.shared.fetchAllItems(passedCatId: passedCatId).map(ItemViewModel.init)
        print("DEBUG: Item fetch count: \(self.items.count)")
        return String(self.items.count)
    }
    
    func addItem(id: String, isComplate: Bool, name: String, passedCatId: String) {
        CoreDataManager.shared.processItem(id: id, isComplete: isComplate, name: name, passedCatId: passedCatId)
        fetchItems(passedCatId: passedCatId)
    }
    
    func deleteItem(_ itemVM: ItemViewModel, passedCatId: String) {
        CoreDataManager.shared.deleteItem(id: itemVM.id)
        fetchItems(passedCatId: passedCatId)
    }
    
    func deleteAllItemsOfCategory(passedCatId: String) {
        self.items = CoreDataManager.shared.fetchAllItems(passedCatId: passedCatId).map(ItemViewModel.init)
        self.items.forEach { (itemToDelete) in
            print(itemToDelete.name)
            CoreDataManager.shared.deleteItem(id: itemToDelete.id)
        }
    }
}

class ItemViewModel {
    var id: String = ""
    var isComplete: Bool
    var name: String = ""
    var passedCategory: CategoryViewModel!
    
    init(item: Item) {
        self.id = item.id!
        self.isComplete = item.isComplete
        self.name = item.name!
    }
}
