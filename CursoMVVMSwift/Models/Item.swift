//
//  Item.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 22/04/25.
//
import Foundation

// Identifiable -> Knows the id (identifier)
// Equatable -> Knows if an instance is equal to another instance
public struct Item: Identifiable, Equatable {
    public let id: String = UUID().uuidString
    public var title: String
    public var note: String?
    public var date: Date
    public var isCompleted: Bool
    public var isArchived: Bool
}
