//
//  ContentView.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var catListVM = CategoryListViewModel(complete: "NO")
    @State private var showAddCategoryView = false
    @State private var pickerSelectedItem = 0
    @State private var sortText = ""
    @State private var searchText = ""
    @State private var isOn = false
    @State private var mode = false
    @State private var modeValue: UIView!
    var itemListVM = ItemListViewModel(passedCatId: "")
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().backgroundColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        //UISwitch.appearance().onTintColor = .orange
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Spacer()
                    Toggle(isOn: $mode) {
                        if !mode {
                            Text("Mode: ")
                                .fontWeight(.bold)
                                +
                                Text("Categories")
                                    .foregroundColor(.orange)
                        } else {
                            Text("Mode: ")
                                .fontWeight(.bold)
                                +
                                Text("Items")
                                    .foregroundColor(.orange)
                        }
                    }
                    Spacer()
                    Spacer()
                } // End HStack
                
                Picker(selection: $pickerSelectedItem.onChange(setSortPicker), label: Text("")) {
                    Text("Due").tag(0)
                    Text("Completed").tag(1)
                    Text("All").tag(2)
                }.padding(10)
                    .pickerStyle(SegmentedPickerStyle())
                
                SearchBar(text: $searchText.onChange(setSearchField))
                
                if !mode {
                    List {
                        ForEach(self.catListVM.categories, id: \.id) { cat in
                            NavigationLink(destination: UpdateCategoryView(passedCategory: cat)) {
                                CategoryCellView(itemCount: self.itemListVM.fetchItemsCount(passedCatId: cat.id), name: cat.name, isImportant: cat.isImportant, isComplete: cat.isComplete, dueDate: DateExtensions.shared.convertDate(type: "Medium", passedDate: cat.dueDate), dueTime: DateExtensions.shared.convertTime(type: "Short", passedDate: cat.dueDate), sortText: self.sortText, searchText: self.searchText, passedCategory: cat, catListVM: self.catListVM, itemListVM: self.itemListVM)
                            } // End NavigationLink
                        } // End ForEach
                            .onDelete(perform: deleteCategory)
                    } // End List
                } else {
                    List {
                        ForEach(self.catListVM.categories, id: \.id) { cat in
                            NavigationLink(destination: ItemView(passedCategory: cat)) {
                                CategoryCellView(itemCount: self.itemListVM.fetchItemsCount(passedCatId: cat.id), name: cat.name, isImportant: cat.isImportant, isComplete: cat.isComplete, dueDate: DateExtensions.shared.convertDate(type: "Medium", passedDate: cat.dueDate), dueTime: DateExtensions.shared.convertTime(type: "Short", passedDate: cat.dueDate), sortText: self.sortText, searchText: self.searchText, passedCategory: cat, catListVM: self.catListVM, itemListVM: self.itemListVM)
                            } // End NavigationLink
                        } // End ForEach
                            .onDelete(perform: deleteCategory)
                    } // End List
                }
            } // End VStack
                .onAppear {
                    //self.pickerSelectedItem = 0
                    if self.sortText != "" {
                        self.catListVM.fetchCategoriesFiltered(searchString: "", complete: self.sortText)
                    } else {
                        self.catListVM.fetchCategoriesFiltered(searchString: "", complete: "NO")
                    }
            } // End OnAppear
                .navigationBarTitle("ToDo List")
                .navigationBarItems(
                    leading:
                    Text(DateExtensions.shared.convertDate(type: "Full", passedDate: Date()))
                        .foregroundColor(.orange)
                    , trailing:
                    NavigationLink(
                        destination: AddCategoryView(),
                        isActive: $showAddCategoryView
                    ) {
                        Button(action: {
                            self.showAddCategoryView.toggle()
                        }, label: {
                            Image(systemName: "square.and.pencil")
                                .font(Font.system(.largeTitle).bold())
                                .font(Font.system(.subheadline))
                                .foregroundColor(.orange)
                        })
                })
        } // End NavigationView
            .accentColor(.orange)
            .environment(\.colorScheme, .dark)
    } // End BodyView
    
    func setSearchField(_ searchString: String) {
        catListVM.fetchCategoriesFiltered(searchString: searchString, complete: sortText)
    }
    
    func setSortPicker(_ tag: Int) {
        print("DEBUG: Sort Tag: \(tag)")
        switch tag {
        case 0:
            sortText = "NO"
            catListVM.fetchCategoriesFiltered(searchString: "", complete: sortText)
        case 1:
            sortText = "YES"
            catListVM.fetchCategoriesFiltered(searchString: "", complete: sortText)
        case 2:
            sortText = "ALL"
            catListVM.fetchCategoriesFiltered(searchString: "", complete: sortText)
        default:
            return
        }
    }
    
    func deleteCategory(at offsets: IndexSet) {
        for item in offsets {
            let categoryToDelete = catListVM.categories[item]
            catListVM.deleteCategory(categoryToDelete, complete: sortText)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            CategoryView()
        }
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
