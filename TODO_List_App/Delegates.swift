//
//  Delegates.swift
//  TODO_List_App
//
//  Created by Raman Kozar on 02/11/2022.
//

import Foundation
import UIKit

protocol SaveUserTaskDelegate: AnyObject {
    func saveTask(task: TaskModel)
}

protocol DeleteUserTaskDelegate: AnyObject {
    func deleteTask(cell: UITableViewCell)
}

protocol CheckUserTaskDelegate: AnyObject {
    func checkTask(cell: UITableViewCell)
}
