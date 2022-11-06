//
//  TaskViewController.swift
//  TODO_List_App
//
//  Created by Raman Kozar on 02/11/2022.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userTaskField: UITextField!
    
    weak var saveTaskDelegate: SaveUserTaskDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTaskField.delegate = self
    }
    
    @IBAction func saveTaskButtonPressed(_ sender: Any) {
        
        if let task = userTaskField.text {
            if !task.isEmpty {
                let task = TaskModel(taskName: task.trimmingCharacters(in: .whitespaces), taskCellColor: "#FFFFFF")
                saveTaskDelegate?.saveTask(task: task)
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: .none)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userTaskField.resignFirstResponder()
        return true
    }
    
}
