//
//  CursoMVVMSwiftApp.swift
//  CursoMVVMSwift
//
//  Created by Gustavo Lizárraga on 9/12/24.
//

import SwiftUI

@main
struct CursoMVVMSwiftApp: App {
    // The main view model for the app
    // StateObject is used to create and manage the lifecycle of the view model
    // This class will be instantiated once and shared across the app
    @StateObject private var viewModel = ToDoViewModel()
    
    // The main entry point of the app
    var body: some Scene {
        WindowGroup {
            // Calls the ContentView and passes the view model
            // like an environment object
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
