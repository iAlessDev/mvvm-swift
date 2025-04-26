//
//  ToDoPersistnceManager.swift
//  CursoMVVMSwift
//
//  Created by Paul Flores on 23/04/25.
//

import CoreData

// this class is used to manage the persistence of the data
final class ToDoPersistenceManager {
    static let shared = ToDoPersistenceManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ModelData")
        container.loadPersistentStores{ storeDescription, error in
            if let error = error {
                print("Error cargando datos: \(error)")
            } else {
                print("Carga de datos exitosa.")
            }
        }
    }
}
