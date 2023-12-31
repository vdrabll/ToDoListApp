//
//  ToDoPresenterProtocol.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import Foundation
import UIKit

protocol ToDoPresenterProtocol {
    var view: ToDoViewProtocol { get set }
    var tasksTitles: [TaskModel] { get set }
    
    func presentAlert() -> Void
    func markComplited(title: String, isChecked: Bool) 
    func deleteTask(task: String, index: Int) -> Bool
    func configure(cell: ToDoTableViewCell, row: Int) -> Void
}
