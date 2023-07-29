//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import UIKit

protocol ToDoTableViewCellProtocol {
    func display(task: String)
    // func check()
}

class ToDoTableViewCell: UITableViewCell, ToDoTableViewCellProtocol {
    
    static let identifire = "ToDoTableViewCell"
    
    var task: UILabel = {
        var lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font.withSize(15.0)
        lable.frame = CGRect(x: 10, y: 10, width: 300, height: 30)
        return lable
    }()
    
    var checkbox: UIButton = {
        var check = UIButton()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.frame = CGRect(x: 350, y: 8, width: 30, height: 30)
        check.backgroundColor = .clear
        check.layer.borderWidth = 0.5
//        check.addGestureRecognizer(UITapGestureRecognizer(target:ToDoTableViewCell.self, action:#selector(<#T##@objc method#>)))
        return check
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func layoutSubviews() {
        addSubview(task)
        addSubview(checkbox)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(task: String) {
        self.task.text = task
    }
    
}

// TODO: make and add checkbox
