//
//  CoreDataProvider.swift
//  ToDoList
//
//  Created by Виктория Федосова on 29.07.2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataProvider {
    func save(task: String)
    func delete(task id: Int)
    func fetchTasks(completionHandler: @escaping ([Task]) -> Void)
}

class CoreDataProviderImplimetation: CoreDataProvider {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func delete(task id: Int) {
        print("im in work")
    }
    
    func save(task: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Task",
                                                              in: context) else {return}
                let taskObject = Task(entity: entity, insertInto: context)
                taskObject.task = task
                do {
                    try context.save()
                } catch let error as NSError {
                    print(error)
                }
    }
    
    func fetchTasks(completionHandler: @escaping ([Task]) -> Void) {
        do {
                let item = try context.fetch(Task.fetchRequest())
            completionHandler(item)
                } catch {
                    print(error.localizedDescription)
                }
        
    }
}
