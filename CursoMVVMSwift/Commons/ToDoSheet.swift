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
 */
struct ToDoSheet<Content>: View where Content: View {
    
    // Modify father view showing property
    @Binding public var isShow: Bool
    
    // Allows closure-style view declarations
    @ViewBuilder public var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(uiColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.4))
                .ignoresSafeArea()
                .onTapGesture {
                    isShow.toggle()
                }
                .animation(nil, value: UUID())
            
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
            .padding(24)
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.main.bounds.height * 0.7)
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
        .animation(nil, value: UUID())
    }
}

#Preview {
    ToDoSheet(isShow: .constant(true)) {
        VStack(spacing: 16) {
            Text("📝 Tarea pendiente")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Esta es una vista de ejemplo dentro del ToDoSheet.")
                .multilineTextAlignment(.center)
            
            Button("Cerrar") {
                print("Cerrar sheet") // solo para demostrar interacción
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

