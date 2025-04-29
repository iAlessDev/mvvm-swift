//
//  NoToDosView.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 29/04/25.
//

import SwiftUI

struct NoToDosView: View {
    @State public var typeOfView: TypeOfView
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: typeOfView.imageOfView)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.7))
            
            Text(typeOfView.textOfView)
                .font(.title2.bold())
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 80)
    }
}

enum TypeOfView {
    case task
    case archived

    var imageOfView: String {
        switch self {
        case .task:
            return "text.page.slash.rtl"
        case .archived:
            return "tray"
        }
    }
    
    var textOfView: String {
        switch self {
        case .task:
            return "There are no tasks"
        case .archived:
            return "There are no archived tasks"
        }
    }
}

#Preview {
    NoToDosView(typeOfView: .task)
}
