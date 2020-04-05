//
//  CategoryCellView.swift
//  ToDoList
//
//  Created by David E Bratton on 4/5/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct CategoryCellView: View {
    
    var itemCount = ""
    var name = ""
    var isImportant: Bool
    var isComplete: Bool
    var dueDate = ""
    var dueTime = ""
    var sortText = ""
    var searchText = ""
    var passedCategory: CategoryViewModel
    var catListVM = CategoryListViewModel(complete: "")
    var itemListVM = ItemListViewModel(passedCatId: "")
    @State private var isOn = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                if isImportant {
                    Text(itemCount)
                        .fontWeight(.bold)
                        .padding(10)
                        .overlay(Circle()
                            .stroke(Color.green, lineWidth: 4))
                } else {
                    Text(itemCount)
                        .fontWeight(.bold)
                        .padding(10)
                        .overlay(Circle()
                            .stroke(Color.orange, lineWidth: 4))
                }
                VStack(alignment: .leading) {
                    HStack(spacing: 5) {
                        Text("Due Date:")
                            .font(.custom("Arial", size: 12))
                            .fontWeight(.bold)
                        Text(dueDate)
                            .font(.custom("Arial", size: 12))
                    } // End HStack
                        .frame(width: 200, alignment: .leading)
                    HStack(spacing: 5)  {
                        Text("Due Time:")
                            .font(.custom("Arial", size: 12))
                            .fontWeight(.bold)
                        Text(dueTime)
                            .font(.custom("Arial", size: 12))
                    } // End HStack
                        .frame(width: 200, alignment: .leading)
                } // End VStack
                
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Toggle(isOn: $isOn) {
                        EmptyView()
                    }
                    .onAppear {
                        self.isOn = self.isComplete
                    }
                    .onTapGesture {
                        self.itemListVM.deleteAllItemsOfCategory(passedCatId: self.passedCategory.id)
                        if self.sortText != "" {
                            self.catListVM.completeCategory(self.passedCategory, complete: self.sortText)
                        } else {
                            self.catListVM.completeCategory(self.passedCategory, complete: "NO")
                        }
                    }                    
                } // End VStack
            } // End HStack
            Text(name)
        } // End VStack
            .padding(10)
    } // End ViewBody
}
