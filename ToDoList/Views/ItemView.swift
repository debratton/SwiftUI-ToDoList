//
//  ItemView.swift
//  ToDoList
//
//  Created by David E Bratton on 4/3/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    
    @ObservedObject var itemListVM = ItemListViewModel(passedCatId: "")
    @Environment(\.presentationMode) var itemsViewMode
    @State private var name: String = ""
    @State private var showAlert = false
    var passedCategory: CategoryViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                TextField("Enter a item...", text: $name)
                .padding(.all, 2)
                .font(Font.system(size: 25, design: .default))
                .multilineTextAlignment(.leading)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    print("DEBUG: Add Item clicked")
                    guard self.name != "" else {
                        self.showAlert.toggle()
                        return
                    }
                    
                    self.itemListVM.addItem(id: UUID().uuidString, isComplate: false, name: self.name, passedCatId: self.passedCategory.id)
                    self.name = ""

                }) {
                    Image(systemName: "plus.circle.fill")
                    .font(Font.system(.title).bold())
                }
                Spacer()
            } // End HStack
            
            List {
                ForEach(self.itemListVM.items, id: \.id) { item in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                            Text(item.name)
                        }
                    } // End VStack
                } // End ForEach
                .onDelete(perform: deleteItem)
            } // End List
        } // End VStack
            .navigationBarTitle(Text("Add Category"))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.itemsViewMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left.circle")
                            .font(Font.system(.title).bold())
                        Text("Back")
                            .font(Font.system(.title).bold())
                    } // End HStack
            }, trailing:
                Text(DateExtensions.shared.convertDate(type: "Full", passedDate: Date())).foregroundColor(.orange))
            .onAppear {
                self.itemListVM.fetchItems(passedCatId: self.passedCategory.id)
        }
        .navigationBarTitle(Text("\(passedCategory.name)"))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error!"), message: Text("Item name is mandatory!"), dismissButton: .default(Text("Close")))
        }
    } // End BodyView
    
    func deleteItem(at offsets: IndexSet) {
        for item in offsets {
            let itemToDelete = itemListVM.items[item]
            itemListVM.deleteItem(itemToDelete, passedCatId: passedCategory.id)
        }
    }
}
