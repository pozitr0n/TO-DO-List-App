//
//  TaskCellTableViewCell.swift
//  TODO_List_App
//
//  Created by Raman Kozar on 02/11/2022.
//

import UIKit

class TaskCellTableViewCell: UITableViewCell {

    @IBOutlet weak var taskCell: UILabel!
    @IBOutlet weak var viewCell: UIView!
    
    weak var deleteTaskDelegate: DeleteUserTaskDelegate?
    weak var checkTaskDelegate: CheckUserTaskDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func removeTaskButtonPressed(_ sender: Any) {
        deleteTaskDelegate?.deleteTask(cell: self)
    }
    
    @IBAction func executeTaskButtonPressed(_ sender: Any) {
        checkTaskDelegate?.checkTask(cell: self)
    }
    
    func cellData(task: TaskModel) {
        taskCell.text = task.taskName
        viewCell.backgroundColor = UIColor(hexaARGB: task.taskCellColor)
    }

}
                                    
