//
//  AlertViewController.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import UIKit

extension ToDoViewController {
    func presentAlert(complitionHandler: @escaping (String) -> ()) {
        
        let alert = UIAlertController(title: "Новая задача",
                                      message: "Введите новую задачу!",
                                      preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "... "
        }
        alert.addAction(UIAlertAction(title: "Выход", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Готово", style: .default, handler:{ [weak self]
            (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    complitionHandler(text)
                }
            }
        }))
        super.present(alert, animated: true)
    }
}


/*DispatchQueue.main.async {
 var currentItem = UserDefaults.standard.stringArray(forKey: "item") ?? []
 UserDefaults.standard.setValue(currentItem,
                                forKey: "item") ///save enter in array
 self?.saveTask(title: text)
//                        reloadData()*/
