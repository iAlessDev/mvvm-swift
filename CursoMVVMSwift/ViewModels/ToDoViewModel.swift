//
//  ToDoViewModel.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 23/04/25.
//

import Foundation
import CoreData
import Combine

// Obsevable object implements @Publisher which allows to update views
public final class ToDoViewModel: ObservableObject {
    // private set allows to:
    // All Elements Reads
    // Only ToDoViewModel Writes
    @Published private(set) var toDos: [ToDoEntity] = []
    
    // Save AnyCancellable Objects from toDos
    var cancellables = Set<AnyCancellable>()
    
    // Database connection
    private var storeContainer: NSPersistentContainer {
        return ToDoPersistenceManager.shared.container
    }
    
    init() {
        fetchToDos()
    }
    
    // Class that init the class and do configurations
    private func fetchToDos() {
        do {
            // Request a List of ToDos
            let request: NSFetchRequest<ToDoEntity> = ToDoEntity.fetchRequest()
            // How would be sort?
            let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
            // I told to the request how will be sort
            // Is in list order due would be multiple params to sort
            request.sortDescriptors = [sortDescriptor]
            // True -> only bring a reference and load when they be used
            // False -> Load all database data now
            request.returnsObjectsAsFaults = false
            // Execute the query to the database and bring me the data
            toDos = try storeContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching toDos")
        }
    }
    
    // Save all the data modified
    // Before this, the data live in memory
    private func saveData() {
        do {
            try storeContainer.viewContext.save()
            fetchToDos()
        } catch {
            print("Error saving data")
        }
    }
    
    /*
      - $0 is equal to each array parameter
      - toDo is a function parameter
      - When the array and function parameter have the same id
        the index array paramter will be asigned to index constant and returned
     */
    private func getToDoIndex(_ toDo: ToDoEntity) -> Int? {
        guard
            let index = toDos.firstIndex(where: {$0.id == toDo.id})
        else {return nil}
        
        return index
    }
    
    // if the number of text characters is 3+ return true
    // else, return false
    public func validateInput(ofText text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespaces).count >= 2
    }
    
    public func addToDo(title: String, note: String, date: Date) {
        let newToDo = ToDoEntity(context: storeContainer.viewContext)
        newToDo.id = UUID().uuidString
        newToDo.title = title
        newToDo.note = note
        newToDo.date = date
        newToDo.isCompleted = false
        newToDo.isArchived = false
        
        saveData()
    }
    
    public func updateToDo(
        _ toDo: ToDoEntity,
        withNewTitle title: String,
        withNewNote note: String,
        withNewDate date: Date
    )
    {
        guard
            let index = getToDoIndex(toDo)
        else {return}
        
        toDos[index].title = title
        toDos[index].note = note
        toDos[index].date = date
        
        saveData()
    }
    
    public func updateToDoStatus(){
        
    }
    
    public func deleteToDo(){
        
    }
    
    public func archiveToDo(){
        
    }
    
    public func unarchiveToDo(){
        
    }
}
