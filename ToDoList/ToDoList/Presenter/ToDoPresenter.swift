//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import Foundation
import CoreData
import UIKit

struct TaskModel {
    var title: String
    var isChecked: Bool
}

class ToDoPresenter: ToDoPresenterProtocol {
    
    var tasksTitles =  [TaskModel]()
    var view: ToDoViewProtocol = ToDoViewController()
    var coreDataProvider: CoreDataProvider
    
    init(view: ToDoViewProtocol, coreDataProvider: CoreDataProviderImplimetation) {
        self.view = view
        self.coreDataProvider = coreDataProvider
        fetchAllTasks()
    }
    
    func markComplited(title: String, isChecked: Bool) {
        var titleIndex = Int()
        
        for (index, tasks) in tasksTitles.enumerated() {  // TODO: исправить нахождение задачи по id
            if tasks.title == title {
                titleIndex = index
            }
        }
        coreDataProvider.update(index: titleIndex, newStatus: isChecked)
    }
    
    func presentAlert() {    // MARK:  работает но выглядит не по солиду надо исправлять
        let vc = view as? ToDoViewController
        vc!.presentAlert { task in
            self.tasksTitles.append(TaskModel(title: task, isChecked: false))
            self.coreDataProvider.save(task: task)
            self.view.updateTableView()
        }
    }
    
    func fetchAllTasks() {
        self.coreDataProvider.fetchTasks { task in
            for title in task {
                self.tasksTitles.append(TaskModel(title: title.task!, isChecked: title.isCheked))
            }
        }
    }
    
    func deleteTask(task: String, index: Int) -> Bool {
        self.tasksTitles.remove(at: index)
        let result = coreDataProvider.delete(id: task, index)
        if result == true {
            return result
        } else {
            return false
        }
    }
    
    func configure(cell: ToDoTableViewCell, row: Int) {
        cell.display(task: self.tasksTitles[row].title)
        cell.display(chekbox: self.tasksTitles[row].isChecked)
    }
}
