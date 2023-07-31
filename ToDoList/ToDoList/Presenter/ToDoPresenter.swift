//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import Foundation
import CoreData
import UIKit

struct Tasks {
    var tittle: String
    var id: Bool
}

class ToDoPresenter: ToDoPresenterProtocol {
    
    var tasksTitles =  [Tasks]()
    var view: ToDoViewProtocol = ToDoViewController()
    var coreDataProvider: CoreDataProvider
    
    init(view: ToDoViewProtocol, coreDataProvider: CoreDataProviderImplimetation) {
        self.view = view
        self.coreDataProvider = coreDataProvider
        fetchAllTasks()
    }
    
    func markComplited(title: String, id: Bool) {
        var titleIndex = Int()
        
        for (index, tasks) in tasksTitles.enumerated() {
            if tasks.tittle == title {
                titleIndex = index
            }
        }
        coreDataProvider.update(index: titleIndex, newStatus: id)

    }
    
    func presentAlert() {    // MARK:  работает но выглядит не по солиду надо исправлять
        let vc = view as? ToDoViewController
        vc!.presentAlert { task in
            self.tasksTitles.append(Tasks(tittle: task, id: false))
            self.coreDataProvider.save(task: task)
            self.view.updateTableView()
        }
    }
    
    func fetchAllTasks() {
        self.coreDataProvider.fetchTasks { task in
            for title in task {
                self.tasksTitles.append(Tasks(tittle: title.task!, id: title.isCheked))
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
        cell.display(task: self.tasksTitles[row].tittle)
        cell.display(chekbox: self.tasksTitles[row].id)
    }
}
