//
//  TaskListTableViewController.swift
//  TODO_List_App
//
//  Created by Raman Kozar on 02/11/2022.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    var arrayUserTasks = [TaskModel]()
    var viewController = TaskViewController()
    let arrayUserTasksKeys: String = "arrayUserTasks"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        
    }

    @IBAction func showTaskVC(_ sender: Any) {
           
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        viewController.saveTaskDelegate = self
        
        present(viewController, animated: true, completion: nil)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUserTasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currCell = tableView.dequeueReusableCell(withIdentifier: "TaskCellTableViewCell") as? TaskCellTableViewCell
        else {
            return UITableViewCell()
        }
        
        currCell.deleteTaskDelegate = self
        currCell.checkTaskDelegate = self
        
        let task = arrayUserTasks[indexPath.row]
        currCell.cellData(task: task)
        
        return currCell
        
    }
    
    func saveData() {
        
        if let encodedData = try? JSONEncoder().encode(arrayUserTasks) {
            UserDefaults.standard.set(encodedData, forKey: arrayUserTasksKeys)
        }
        
    }
    
    func loadData() {
        guard
            let data = UserDefaults.standard.data(forKey: arrayUserTasksKeys),
            let savedArray = try? JSONDecoder().decode([TaskModel].self, from: data)
        else { return }
        
        self.arrayUserTasks = savedArray
    }
    
}

extension TaskListTableViewController: SaveUserTaskDelegate, DeleteUserTaskDelegate, CheckUserTaskDelegate {
   
    func deleteTask(cell: UITableViewCell) {
    
        let currIndexPath = tableView.indexPath(for: cell)
        
        if currIndexPath?.row != nil {
            
            arrayUserTasks.remove(at: currIndexPath!.row)
            saveData()
            tableView.reloadData()
            
        }
        
    }
    
    func checkTask(cell: UITableViewCell) {
    
        let currIndexPath = tableView.indexPath(for: cell)
        
        if currIndexPath != nil {
            
            let selectedCell = tableView.cellForRow(at: currIndexPath!)!
            
            selectedCell.contentView.backgroundColor = UIColor(hexaARGB: "#8F8F8F")
            arrayUserTasks[currIndexPath!.row].taskCellColor = "#8F8F8F"
            saveData()
            
        }
        
    }
    
    func saveTask(task: TaskModel) {
       
        arrayUserTasks.append(task)
        saveData()
        tableView.reloadData()
        
    }
    
}

extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: alpha)
    }
    
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
}
