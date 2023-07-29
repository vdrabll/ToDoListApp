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
    var item = [String]()
    
    init(view: ToDoViewProtocol, coreDataProvider: CoreDataProviderImplimetation) {
        self.view = view
        self.coreDataProvider = coreDataProvider
        fetchAllTasks()
    }
    
    func markComplited() {
        print("im here")
    }
    
    func presentAlert() {
        let vc = view as? ToDoViewController
        vc!.presentAlert { task in
            self.item.append(task)
            self.coreDataProvider.save(task: task)
        }
    }
    
    func fetchAllTasks() {
        self.coreDataProvider.fetchTasks { task in
            for i in task {
                self.item.append(i.task!)
            }
        }
    }
    
    func configure(cell: ToDoTableViewCell, row: Int) {
        cell.display(task: self.item[row])
        }
    
    func deleteTask(at indexPath: IndexPath) {
        // some code here later
        
        }
    }
