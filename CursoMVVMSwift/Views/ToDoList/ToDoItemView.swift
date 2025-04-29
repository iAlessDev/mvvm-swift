//
//  ToDoItemView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 24/04/25.
//

import SwiftUI

public struct ToDoItemView: View {
    
    @EnvironmentObject private var viewModel: ToDoViewModel
    public let toDo: ToDoEntity
    
    
    public var body: some View {
        
        if !toDo.id.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment:.top, spacing: 4) {
                    Text(toDo.date ?? Date(), format: .dateTime.day())
                        .font(.system(size: 44, weight: .semibold))
                        .padding(.top, -8)
                        .foregroundStyle(Color(UIColor.white))
                    VStack(alignment: .leading, spacing: 0) {
                        Text(toDo.date ?? Date(), format: .dateTime.month())
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                        Text(toDo.date ?? Date(), format: .dateTime.weekday(.abbreviated))
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, -2)
                    Spacer(minLength: 2)
                    ToDoStatusView(toDo: toDo)
                        .onTapGesture {
                            withAnimation(.interactiveSpring) {
                                viewModel.updateToDoStatus(for: toDo)
                            }
                        }
                }
                VStack(alignment: .leading) {
                    Text(toDo.title ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .lineLimit(2)
                    if let note = toDo.note {
                        Text(note)
                            .font(.body)
                            .bold()
                            .lineLimit(2)
                            .foregroundStyle(Color.white)
                    }
                    
                    
                }
                Spacer(minLength: 8)
                HStack(spacing: 4){
                    Text("Hora:")
                        .foregroundStyle(Color.white)
                    Text(toDo.date ?? Date(), format: .dateTime.hour().minute())
                        .fontWeight(.thin)
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(3)
                        .foregroundStyle(Color.white)
                        
                }
            }
            .ignoresSafeArea(edges: .top)
            .padding()
            .background(Color.indigo)
            .clipShape(.rect(cornerRadius: 10))
            
        }
    }
}


#Preview {
}
