//
//  ToDoPreviewView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 25/04/25.
//
import SwiftUI

struct ToDoPreviewView: View {
    
    // Class that is used to edit the preview of the ToDo
    
    // MARK: - Properties
    // Te enviroment object doesnt need to be passed from the ToDoListView manually
    // because it is already in the environment since ContentView injected it to all the app
    // Currenly, is not used
    @EnvironmentObject var viewModel: ToDoViewModel
    
    // Binding to the ToDo entity that is being edited and passed from the ToDoListView
    @Binding public var toDo: ToDoEntity?
    
    // State that say if the ToDo creation sheet is shown
    @State private var showedTodoCreationSheet: Bool = false
    
    // State that say if the toDo will be archived or unarchived
    private var archivedActionText: String {
        if let toDo = toDo {
            return toDo.isArchived ? "Unarchive" : "Archive"
        } else {
            return ""
        }
    }
    
    // MARK: - Body
    var body: some View {
        
        // Check if the toDo is not nil
        if let safeToDo = toDo {
            
            ZStack(alignment: .bottom) {
                
                
                Rectangle()
                    .fill(.thinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            toDo = nil
                        }
                    }
                
                
                VStack(spacing: 36) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(Date(),
                                 format: .dateTime
                                .weekday(.wide)
                                .day()
                                .month()
                                .year()
                                .hour()
                                .minute())
                            .foregroundStyle(Color.white)
                            
                            
                            Text(safeToDo.title ?? "")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                        }
                        Spacer()
                        ToDoStatusView(toDo: safeToDo)
                    }
                    
                    if let note = safeToDo.note {
                        Text(note)
                            .font(.body)
                            .foregroundStyle(Color.white)
                            .lineLimit(2)
                    }
                    
                    
                    HStack(spacing: 16) {
                        Button {
                            showedTodoCreationSheet = true
                        } label: {
                            Text("Edit")
                                .frame(maxWidth: .infinity)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 32)
                                .overlay {
                                    Capsule(style: .circular)
                                        .stroke(Color.white, lineWidth: 1)
                                }
                        }
                        Spacer()
                        Button {
                            withAnimation(.easeInOut) {
                                viewModel.toggleArchiveStatus(for: safeToDo)
                                toDo = nil
                            }
                        } label: {
                            Text(archivedActionText)
                                .frame(maxWidth: .infinity)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 32)
                                .overlay {
                                    Capsule(style: .circular)
                                        .stroke(Color.white, lineWidth: 1)
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.indigo)
                .clipShape(.rect(cornerRadius: 10))
                .padding(8)
                
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .frame(maxHeight: UIScreen.main.bounds.height)
            .zIndex(1)
            // if the toDo is not nil, show the ToDoSheet
            // Display edit a ToDo Menu
            .overlay {
                if showedTodoCreationSheet {
                    ToDoSheet(
                        isShow: $showedTodoCreationSheet
                    ){
                        ToDoAddView(
                            showed: $showedTodoCreationSheet,
                            toDo: safeToDo
                        )
                    }
                    .ignoresSafeArea(.keyboard)
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.3), value: toDo)
        }
    }
}
