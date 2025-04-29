//
//  ToDoStatusView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 24/04/25.
//


import SwiftUI

public struct ToDoStatusView: View {
    @EnvironmentObject private var viewModel: ToDoViewModel
    public let toDo: ToDoEntity
    
    public let disabled: Bool
    
    public init(
        toDo: ToDoEntity,
        disabled: Bool = false
    ) {
        self.toDo = toDo
        self.disabled = disabled
    }
    
    public var body: some View {
        let imageName: String = toDo.isCompleted ? "checkmark.circle.fill" : "circle"
        let width: CGFloat = toDo.isCompleted ? 24 : 18
        let height: CGFloat = width
        
        
        return Image(systemName: imageName)
            .resizable()
            .frame(width: width, height: height)
            .foregroundStyle(Color.white)
            
    }
    
}

