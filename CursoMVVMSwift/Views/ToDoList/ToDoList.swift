//
//  ToDoListView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 24/04/25.
//


import SwiftUI

public struct ToDoList: View {
    
    // EnviromentObject is used to inject the view model into the view hierarchy
    @EnvironmentObject var viewModel: ToDoViewModel
    
    // State variables to manage the state of the view
    // like showing the sheet or the preview
    @State var isShowedSheet: Bool = false
    
    // Assigned every time the user taps on a ToDoItemView
    @State var toDoPreview: ToDoEntity?
    
    // Computed property to filter the ToDoEntity objects
    // across the view model
    private var unArchivedToDos: [ToDoEntity] {
        viewModel.toDos.filter { !$0.isArchived }
    }
    
    // GridItem to create a grid layout
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    public var body: some View {
        ZStack(alignment: .center) {
            ScrollView {
                // if the unArchivedToDos array is not empty
                // display the ToDoItemView in a grid layout
                if !unArchivedToDos.isEmpty {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(unArchivedToDos) { toDo in
                            ToDoItemView(toDo: toDo)
                            // onTapGesture to show the preview
                                .onTapGesture {
                                    withAnimation {
                                        // Here is where the toDo is assigned
                                        toDoPreview = toDo
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Overlay
            .overlay {
                // if isShowedSheet is true, show the ToDoSheet
                // Display add a new ToDo Menu
                if isShowedSheet {
                    ToDoSheet(isShow: $isShowedSheet) {
                        withAnimation {
                            ToDoAddView(showed: $isShowedSheet)
                        }
                    }
                    
                // If toDoPreview variable is not nil, show the ToDoPreview
                // Edit a ToDo menu
                // With $ you're passing a binding to the ToDoPreviewView
                // Without $ you're passing a copy of the ToDoPreviewView
                } else if toDoPreview != nil {
                    withAnimation {
                        ToDoPreviewView(toDo: $toDoPreview)
                    }
                    
                }
            }
            .navigationTitle("ToDos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        NavigationLink {
                            ToDoArchivedListView()
                                .environmentObject(viewModel)
                        } label: {
                            Image(systemName: "tray")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color.primary)
                        }
                        Button {
                            // Button to show the ToDoSheet
                            // is used to add a new ToDo
                            withAnimation(.easeOut) {
                                isShowedSheet.toggle()
                            }
                        } label: {
                            // Button to add a new ToDo
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(Color.primary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        ToDoList().environmentObject(ToDoViewModel())
    }
}
