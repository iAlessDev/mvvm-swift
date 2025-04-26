//
//  ContentView.swift
//  CursoMVVMSwift
//
//  Created by Gustavo Lizárraga on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    // View Model for the app that manages the state and data
    // Passed by CursoMVVMSwiftApp.swift
    @EnvironmentObject private var viewModel: ToDoViewModel

    // The main view of the app
    var body: some View {
        // Calls the ToDoList view and passes the view model like
        // an environment object
        NavigationView {
            ToDoList().environmentObject(viewModel)
        }
        .tint(Color.primary)
    }
}

#Preview {
    ContentView().environmentObject(ToDoViewModel())
}
