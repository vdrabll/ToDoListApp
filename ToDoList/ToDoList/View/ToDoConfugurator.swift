//
//  ToDoConfugurator.swift
//  ToDoList
//
//  Created by Виктория Федосова on 29.07.2023.
//

import Foundation

protocol ToDoConfuguratorProtocol {
    func configure(ToDoViewController: ToDoViewController)
}

class ToDoConfiguratorImplementation: ToDoConfuguratorProtocol {
    func configure(ToDoViewController: ToDoViewController) {
    let coreDataProvider = CoreDataProviderImplimetation()
    let presenter = ToDoPresenter(view: ToDoViewController, coreDataProvider: coreDataProvider)
        ToDoViewController.presenter = presenter
    }
}
