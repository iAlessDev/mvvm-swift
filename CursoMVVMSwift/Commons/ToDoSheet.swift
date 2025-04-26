//
//  ToDoSheet.swift
//  CursoMVVMSwift
//
//  Created by Gustavo Lizárraga on 9/12/24.
//

import SwiftUI

/*
 ToDoSheet<Content>: View -> Generic Parameter of the ToDoSheetView
 Where Content: View -> Content should be a view
 
 The function ToDoSheet is like a background template
 that can be used in multiple views
 */
struct ToDoSheet<Content>: View where Content: View {
    
    // Modify father view showing property
    @Binding public var isShow: Bool
    
    // Allows closure-style view declaration
    // The view builder allows the use of closures to create multiple views
    // and is returned as a single view
    // in this case the toDoAddView
    @ViewBuilder public var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4))
                .ignoresSafeArea()
                .onTapGesture {
                    isShow.toggle()
                }
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isShow.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 18)
                            .frame(height: 18)
                            .tint(Color.primary)
                    }
                }
                content()
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.6)
            .background(
                Color(UIColor.secondarySystemBackground)
            )
            .clipShape(
                ToDoRoundedCorner(
                    radius: 20,
                    corners: [.topLeft, .topRight]
                )
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .zIndex(2.0)
        .transition(.move(edge: .bottom))
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isShow)
    }
}

#Preview {
    ToDoSheet(isShow: .constant(true)) {
        ToDoAddView(showed: .constant(true))
            .environmentObject(ToDoViewModel())
    }
}

