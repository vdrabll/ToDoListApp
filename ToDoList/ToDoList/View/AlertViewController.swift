//
//  AlertViewController.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import UIKit

extension ToDoViewController {
    func presentAlert(complitionHandler: @escaping (String) -> ()) {
        
        let alert = UIAlertController(title: "New Task",
                                      message: "Please enter new task",
                                      preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "... "
        }
        alert.addAction(UIAlertAction(title: "Exit", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Right", style: .default, handler:{ [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    complitionHandler(text)
                }
            }
        }))
        super.present(alert, animated: true)
    }
}
