//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import Foundation
import CoreData
import UIKit

class ToDoPresenter: ToDoPresenterProtocol {
    
    var view: ToDoViewProtocol
    var coreDataProvider: CoreDataProvider
    var tasksTitles = [String]()
    
    init(view: ToDoViewProtocol, coreDataProvider: CoreDataProviderImplimetation) {
        self.view = view
        self.coreDataProvider = coreDataProvider
        fetchAllTasks()
    }
    
    func markComplited() -> Bool{
        return true
    }
    
    func presentAlert() {    // MARK:  работает но выглядит не по солиду надо исправлять
        let vc = view as? ToDoViewController
        vc!.presentAlert { task in
            self.tasksTitles.append(task)
            self.coreDataProvider.save(task: task)
            DispatchQueue.main.async {
                vc!.tableView.reloadData()
            }
        }
    }
    
    func fetchAllTasks() {
        self.coreDataProvider.fetchTasks { task in
            for title in task {
                self.tasksTitles.append(title.task!)
            }
        }
    }
    
    func deleteTask(task: String, index: Int) -> Bool {
        self.tasksTitles.remove(at: index)
       let result = coreDataProvider.delete(task: task, index: index)
        if result == true {
            return result
        } else {
            return false
        }
    }
    
    func configure(cell: ToDoTableViewCell, row: Int) {
        cell.display(task: self.tasksTitles[row])
    }
}
