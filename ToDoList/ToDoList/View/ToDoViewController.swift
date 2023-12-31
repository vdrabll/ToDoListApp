//
//  ViewController.swift
//  ToDoList
//
//  Created by Виктория Федосова on 19.04.2022.
//

import UIKit

class ToDoViewController: UITableViewController, ToDoViewProtocol, ToDoTableViewCellDelegate {
    
    // MARK: Class properties
    var presenter: ToDoPresenterProtocol!
    var confugurator = ToDoConfiguratorImplementation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confugurator.configure(ToDoViewController: self)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: String(describing: ToDoTableViewCell.self))
        setTitle(title: "")
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
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // MARK: Cell delegate methods
    func taskChecked(status: Bool, title: String) {
        presenter.markComplited(title: title, isChecked: status)
    }
    
    func updateTask(title: String) {
        print("im gonna be ready soon")
    }
    
    // MARK: Table View Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tasksTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.identifire, for: indexPath) as! ToDoTableViewCell
        presenter!.configure(cell: cell , row: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let task = (tableView.visibleCells[indexPath.item] as! ToDoTableViewCell).task.text else {
            fatalError("task not found")
        }
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            if presenter.deleteTask(task: task, index: indexPath.item) == true {
                tableView.endUpdates()
            } else {
                fatalError("some problems happend when deliting task was performing")
            }
        }
        return
    }
}

