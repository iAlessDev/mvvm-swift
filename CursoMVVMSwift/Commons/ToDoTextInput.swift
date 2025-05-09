//
//  ToDoTextInput.swift
//  CursoMVVMSwift
//
//  Created by Gustavo Lizárraga on 9/12/24.
//

import SwiftUI

public struct ToDoTextInput: View {
    
    public var label: String?
    public let placeholder: String
    public var variant: Variant?
    
    @Binding public var text: String
    
    public enum Variant {
        case textField
        case textEditor
    }
    
    init(
        _ placeholder: String,
        text: Binding<String>,
        label: String? = nil,
        variant: Variant? = .textField
    ) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.variant = variant
    }
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            if let label = label {
                Text(label)
                    .font(.title3)
            }
            
            switch variant {
            case .textField:
                TextField(placeholder, text: $text)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(10)
            case .textEditor:
                ZStack(alignment: .topLeading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .font(.body)
                            .foregroundStyle(Color(UIColor.tertiaryLabel))
                            .padding(.top)
                            .animation(nil, value: text)
                    }
                    TextEditor(text: $text)
                        .font(.body)
                        .padding(.horizontal, -4)
                        .padding(.top, 8)
                }
                .padding(.horizontal)
                .frame(height: 76)
                .transparentScrolling()
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(10)
            default:
                EmptyView()
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        Text("Preview")
            .font(.headline)
        Spacer()
        ToDoTextInput(
            "Add a new to-do",
            text: .constant("I'm doing great!"),
            label: "Hi, How're you?",
            variant: .textField
        )
    }
    .padding(20)
    .background(Color.gray.opacity(0.2))
}
