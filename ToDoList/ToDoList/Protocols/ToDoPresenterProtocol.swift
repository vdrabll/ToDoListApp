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
    var item: [String] { get set }
    
    func presentAlert()
    func markComplited()
    func deleteTask(at indexPath: IndexPath)
    func configure(cell: ToDoTableViewCell, row: Int)
}
