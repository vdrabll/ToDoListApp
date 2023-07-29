//
//  ToDoViewProtocol.swift
//  ToDoList
//
//  Created by Виктория Федосова on 28.07.2023.
//

import Foundation
import UIKit
 
protocol ToDoViewProtocol {
    var presenter: ToDoPresenterProtocol! { get set }
    
    func setTitle(title: String)
}


