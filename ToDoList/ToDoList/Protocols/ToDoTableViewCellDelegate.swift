//
//  ToDoTableViewCellDelegate.swift
//  ToDoList
//
//  Created by Виктория Федосова on 30.07.2023.
//

import Foundation

protocol ToDoTableViewCellDelegate {
    func taskChecked(status: Bool, title: String)
    func updateTask(title: String)
}
