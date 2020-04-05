//
//  UpdateCategoryView.swift
//  ToDoList
//
//  Created by David E Bratton on 4/2/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct UpdateCategoryView: View {
    
    @Environment(\.presentationMode) var addCategoryViewMode
    @State private var showAlert = false
    @State private var id = ""
    @State private var name = ""
    @State private var dueDate = Date()
    @State private var dueTime = Date()
    @State private var isImportant = false
    @State private var isComplete = false
    var passedCategory: CategoryViewModel
    var catListVM = CategoryListViewModel(complete: "")

    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 10) {
                Text("Category Name")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                TextField("Enter a category...", text: $name)
                    .padding(.all, 2)
                    .font(Font.system(size: 25, design: .default))
                    .multilineTextAlignment(.leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onAppear {
                        self.id = self.passedCategory.id
                        self.name = self.passedCategory.name
                }
            } // End VStack
            
            HStack {
                Toggle(isOn: $isImportant) {
                    Text("Important")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                }
                .onAppear {
                    self.isImportant = self.passedCategory.isImportant
                }
                .onTapGesture {
                    self.isImportant.toggle()
                }
                
                Toggle(isOn: $isComplete) {
                    Text("Complete")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                }
                .onAppear {
                    self.isComplete = self.passedCategory.isComplete
                }
                .onTapGesture {
                    self.isComplete.toggle()
                }
            } // End HStack
            .frame(width: 320, height: 50, alignment: .leading)
            
            VStack(spacing: 5) {
                Text("Due Date")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                DatePicker(selection: $dueDate, displayedComponents: .date) {
                    Text("")
                }.labelsHidden()
                    .onAppear {
                        self.dueDate = self.passedCategory.dueDate
                }
            } // End VStack
            
            VStack(spacing: 5) {
                Text("Due Time")
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                DatePicker(selection: $dueTime, displayedComponents: .hourAndMinute) {
                    Text("")
                }.labelsHidden()
                    .onAppear {
                        self.dueTime = self.passedCategory.dueTime
                }
            } // End VStack
            
            Button(action: {
                print("DEBUG: Update Category Pressed...")
                guard self.name != "" else {
                    self.showAlert.toggle()
                    return
                }
                
                self.catListVM.updateCategory(id: self.id, dueDate: self.dueDate, dueTime: self.dueTime, isComplete: self.isComplete, isImportant: self.isImportant, name: self.name)
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
        .navigationBarTitle(Text("Update Category"))
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
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text("Category name is mandatory!"), dismissButton: .default(Text("Close")))
        }
    } // End BodyView
}
