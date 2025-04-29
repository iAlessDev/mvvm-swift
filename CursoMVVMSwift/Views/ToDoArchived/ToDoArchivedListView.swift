//
//  ToDoArchivedListView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 24/04/25.
//

import SwiftUI

public struct ToDoArchivedListView: View {
    @EnvironmentObject var viewModel: ToDoViewModel
    @State private var toDoPreview: ToDoEntity?
    
    private var archivedToDosList: [ToDoEntity] {
        viewModel.toDos.filter { $0.isArchived }
    }
    
    
    public var body: some View {
        ZStack {
            ScrollView {
                
                // MARK: - Empty State
                if archivedToDosList.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.7))
                        
                        Text("There are no archived tasks")
                            .font(.title2.bold())
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 80)
                    
                // MARK: - Archived ToDo List
                } else {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(archivedToDosList) { toDo in
                            ArchivedToDoItemView(toDo: toDo)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Archived")
        }
        .overlay {
            if let toDoPreview {
                withAnimation {
                    ToDoPreviewView(toDo: .constant(toDoPreview))
                }
            }
        }
    }
}


// MARK: - Archived ToDo Item View
private struct ArchivedToDoItemView: View {
    
    let toDo: ToDoEntity
    @EnvironmentObject var viewModel: ToDoViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(toDo.title ?? "")
                .font(.title2.bold())
                .lineLimit(1)
                .padding(.top, -4)

            HStack(spacing: 16) {
                Text(toDo.note ?? "")
                    .font(.body)

                Spacer()

                ToDoStatusView(toDo: toDo)
                    .onTapGesture {
                        withAnimation {
                            viewModel.updateToDoStatus(for: toDo)
                        }
                    }

                Button {
                    withAnimation {
                        viewModel.deleteToDo(toDo)
                    }
                } label: {
                    Image(systemName: "trash")
                        .tint(Color(UIColor.systemPink))
                }

                Button {
                    withAnimation(.bouncy()) {
                        viewModel.toggleArchiveStatus(for: toDo)
                    }
                } label: {
                    Image(systemName: "plus")
                        .tint(Color.blue.opacity(0.9))
                }
                
                
            }

            Spacer()

            if let date = toDo.date {
                Text(date, format: .dateTime.day().month())
                    .padding(10)
                    .foregroundStyle(Color.white.opacity(0.8))
                    .font(.system(size: 14, weight: .semibold))
                    .background(Color.black.opacity(0.9))
                    .clipShape(.rect(cornerRadius: 10))
            }
        }
        .padding(25)
        .background(Color.gray.opacity(0.6))
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ToDoArchivedListView()
        .environmentObject(ToDoViewModel())
    
}
