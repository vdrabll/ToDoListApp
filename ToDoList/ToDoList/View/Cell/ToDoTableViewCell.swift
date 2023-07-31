//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import UIKit

protocol ToDoTableViewCellProtocol {
    
    func display(task: String)
    func display(chekbox status: Bool)
}

class ToDoTableViewCell: UITableViewCell, ToDoTableViewCellProtocol {
    
    static let identifire = "ToDoTableViewCell"
    
    var delegate: ToDoTableViewCellDelegate?
    
    var task: UILabel = {
        var lable = UILabel()
        // TODO: make 4 rows 
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font.withSize(15.0)
        lable.frame = CGRect(x: 10, y: 10, width: 300, height: 30)
        return lable
    }()
    
    lazy var checkbox: UIButton = {
        var check = UIButton()
        check.translatesAutoresizingMaskIntoConstraints = false
        check.frame = CGRect(x: 350, y: 8, width: 30, height: 30)
        check.backgroundColor = .clear
        check.layer.borderWidth = 0.5
        check.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(checkBox)))
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
    
    @objc func checkBox() {
        switch checkbox.backgroundColor {
        case UIColor.clear:
            self.delegate?.taskChecked(status: true, title: task.text!)
            
            case UIColor.black:
            self.delegate?.taskChecked(status: false, title: task.text!)

            case .none:
                break
            case .some(_):
            self.delegate?.taskChecked(status: true, title: task.text!)
            }
        }
    
    func display(task: String) {
        self.task.text = task
    }
    
    func display(chekbox status: Bool) {
        switch status {
        case false:
            self.checkbox.backgroundColor = .clear
            self.task.attributedText = NSAttributedString(string: task.text!)
            
        case true:
            self.checkbox.backgroundColor = .black
            self.task.attributedText = NSAttributedString(string: task.text!, attributes: checkBoxStyle.isChecked.style)
            
        }
    }
}

enum checkBoxStyle {
    static let isChecked = (color: UIColor.black,
                            style: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue] )
    static let isNotChecked = (color: UIColor.clear,
                               style:[NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.patternDot.rawValue] )
}
