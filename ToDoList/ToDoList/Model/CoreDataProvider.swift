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
    func delete(task: String, index: Int) -> Bool
    func fetchTasks(completionHandler: @escaping ([Task]) -> Void)
}

class CoreDataProviderImplimetation: CoreDataProvider {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func delete(task: String, index: Int) -> Bool {
        var data = [Task]()
        // MARK: не очень красиво надо бы как то улучшить
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
          fatalError("entity not found")
        }
        self.fetchTasks { task in
            data = task
        }
        
       do {
           self.context.delete(data[index])
           try context.save()
           return true
       } catch let error as NSError {
           print(String(describing: error.localizedDescription))
           return false
       }
    }
    
    func save(task: String) {
        if task == "" {
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
            fatalError("entity not found")
        }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.task = task
        
        do {
            try context.save()
        } catch let error as NSError {
            print(String(describing: error.localizedDescription))
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
