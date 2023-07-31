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
    func delete(id: UUID)
    func fetchTasks(completionHandler: @escaping ([Task]) -> Void)
    func update(task: String) -> Bool
    func update(index: Int, newStatus: Bool) -> Bool
}

class CoreDataProviderImplimetation: CoreDataProvider {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func delete(id: UUID) -> Bool {
        var data = [Task]()
        // MARK: не очень красиво надо бы как то улучшить
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
            fatalError("entity not found")
        }
        self.fetchTasks { task in
            data = task
        }
        
        do {
//            self.context.delete(data[index])
            try context.save()
            return true
        } catch let error as NSError {
            print(String(describing: error.localizedDescription))
            return false
        }
    }
    
    func save(task: String) {
        if task == nil {
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else {
            fatalError("entity not found")
        }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.task = task
        taskObject.isCheked = false
        
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
    
    func update(task: String) -> Bool {
        return false
    }
    
    func update(index: Int, newStatus: Bool) -> Bool {
        var tasks = [Task]()
        
        fetchTasks { data in
            tasks = data
        }
        let task = tasks[index]
        task.isCheked = newStatus
        
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print(String(describing: error.localizedDescription))
        }
        return true
    }
}
