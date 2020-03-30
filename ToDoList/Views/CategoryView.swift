//
//  ContentView.swift
//  ToDoList
//
//  Created by David E Bratton on 3/29/20.
//  Copyright © 2020 David E Bratton. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var showAddCategoryView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("LIST WILL GO HERE")
            } // End VStack
                .navigationBarTitle("ToDo List")
                .navigationBarItems(
                    leading:
                    EditButton()
                        .font(Font.system(.largeTitle).bold())
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
