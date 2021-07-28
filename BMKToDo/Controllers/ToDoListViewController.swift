//
//  ToDoListViewController.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 27/07/21.
//


import UIKit
import CoreData

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var toDoListTableView: UITableView!
    
    var taskID: Int = 0
    var isAddNew: Bool = false
    
    private var todoListVM: TodoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toDoListTableView.tableFooterView = UIView()
        todoListVM = TodoListViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        todoListVM.todoSectionDataList = TodoListViewModel().refershTodoList()
        self.toDoListTableView.reloadData()
    }
  
   //MARK:- Add Task btn action
    @objc func addTaskBtnAction(_ sender: UIButton) {
        taskID = sender.tag
        isAddNew = true
        performSegue(withIdentifier: "toCreateTaskSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateTaskSegue" {
            let vc = segue.destination as! TaskViewController
            vc.todoTaskVM = TodoViewModel(sender as? TodoTask, taskID, isAddNew)
        }
    }
}

//MARK:- TableViewDelegate and datasource

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.todoListVM == nil ? 0 : self.todoListVM.numberOFSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        
        let cellObject = todoListVM.todoTaskAtIndex(indexPath.section, indexPath.row)
        cell.loadTaskCellData(cellObject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellObject = todoListVM.todoTaskAtIndex(indexPath.section, indexPath.row)
        taskID = todoListVM.getSectionID(indexPath.section)
        isAddNew = false
        performSegue(withIdentifier: "toCreateTaskSegue", sender: cellObject)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let cellObject = todoListVM.todoTaskAtIndex(indexPath.section, indexPath.row)
            todoListVM.deleteTodoItemFromList(cellObject)
            self.toDoListTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as? ToDoHeaderCell else {
            return UITableViewCell()
        }
        headerCell.addTaskBtn.addTarget(self, action: #selector(addTaskBtnAction(_:)) , for: UIControl.Event.touchUpInside)
        
        let headerData = todoListVM.getTodoHeaderObject(section)
        headerCell.loadSectionData(headerData)
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}


