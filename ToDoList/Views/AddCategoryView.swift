//
//  AddCategoryView.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct AddCategoryView: View {
    
    @Environment(\.presentationMode) var addCategoryViewMode
    @State private var showAlert = false
    @State private var name = ""
    @State private var dueDate = Date()
    @State private var isImportant = false
    @State private var isComplete = false
    var catListVM = CategoryListViewModel(complete: "")
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Spacer()
            VStack(spacing: 10) {
                Text("Category Name")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                TextField("Enter a category...", text: $name)
                    .padding(.all, 2)
                    .font(Font.system(size: 25, design: .default))
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } // End VStack
                Spacer()
                Spacer()
            } // End HStack
            
            HStack {
                Toggle(isOn: $isImportant) {
                    Text("Important")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                }.onTapGesture {
                    self.isImportant.toggle()
                }
                Toggle(isOn: $isComplete) {
                    Text("Complete")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                }.onTapGesture {
                    self.isComplete.toggle()
                }
            } // End HStack
            .frame(width: 320, height: 50, alignment: .leading)
            
            VStack(spacing: 5) {
                Text("Due Date")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                DatePicker(selection: $dueDate) {
                    Text("")
                }.labelsHidden()
            } // End VStack
            
            Button(action: {
                print("DEBUG: Save Category Pressed...")
                guard self.name != "" else {
                    self.showAlert.toggle()
                    return
                }

                self.catListVM.addCategory(id: UUID().uuidString, dueDate: self.dueDate, isComplete: self.isComplete, isImportant: self.isImportant, name: self.name)
                self.addCategoryViewMode.wrappedValue.dismiss()
                
            }) {
                Text("Save Category")
                .fontWeight(.bold)
                .font(.title)
                .padding(5)
                .background(Color.orange)
                .foregroundColor(.black)
                .padding(10)
                .border(Color.orange, width: 5)
            }
            Spacer()
        } // End VStack
        .navigationBarTitle(Text("Add Category"))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.addCategoryViewMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle")
                        .font(Font.system(.title).bold())
                    Text("Back")
                        .font(Font.system(.title).bold())
                } // End HStack
            }, trailing:
            Text(DateExtensions.shared.convertDate(type: "Full", passedDate: Date())).foregroundColor(.orange))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text("Category name is mandatory!"), dismissButton: .default(Text("Close")))
        }
    } // End BodyView
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
