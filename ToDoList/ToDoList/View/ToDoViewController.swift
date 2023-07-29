//
//  ViewController.swift
//  ToDoList
//
//  Created by Виктория Федосова on 19.04.2022.
//

import UIKit

class ToDoViewController: UITableViewController, ToDoViewProtocol  {
    var presenter: ToDoPresenterProtocol!
    
    var confugurator = ToDoConfiguratorImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugurator.configure(ToDoViewController: self)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifire)
        setTitle(title: " " )
      
    }
    
    func setTitle(title: String) {
        // TODO: Make right text for title
        navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc func didTapAdd() {
        presenter.presentAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.item.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifire, for: indexPath)
        presenter!.configure(cell: cell as! ToDoTableViewCell, row: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete ///
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            return presenter.deleteTask( at: indexPath)
        }
    }
}
