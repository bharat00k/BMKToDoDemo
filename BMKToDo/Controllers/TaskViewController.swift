//
//  TaskViewController.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//


import UIKit
import CoreData


class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTF: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
   
    var todoTaskVM: TodoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTodoTaskView()
    }
    
    //MARK:- Set UI Data Here
    private func updateTodoTaskView() {
        
        setTextViewBorder()
        
        if let todoTaskVM = todoTaskVM {
            taskNameTF.text = todoTaskVM.taskName
            taskDescriptionTextView.text = todoTaskVM.descriptionText

            if todoTaskVM.isUpdate {
                saveBtn.title = "Save"
            } else {
                saveBtn.title = "Update"
            }
        }
    }
    
    //MARK:- Set TextView Corners
    private func setTextViewBorder() {
        taskDescriptionTextView.layer.borderWidth = 0.5
        taskDescriptionTextView.layer.masksToBounds = true
        taskDescriptionTextView.layer.cornerRadius  = 10
        taskDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK:- Back btn action
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Save btn action
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        
        if let taskName = taskNameTF.text, !taskName.isEmpty {
            self.storeTaskData(taskName, taskDescriptionTextView.text ?? "NA")
            navigationController?.popViewController(animated: true)
        } else {
            
            let alertVC = UIAlertController(title: "Error", message: "Task name should not be empty", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            }
            alertVC.addAction(alertAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
    
  
    //MARK:- Save Todo data in CoreData
    func storeTaskData(_ taskName: String, _ taskDiscription: String) {
        
        if let todoTaskVM = self.todoTaskVM {
            if todoTaskVM.isUpdate {
                todoTaskVM.addNewTodoTask(taskName, taskDiscription, todoTaskVM.getTaskType())
            } else {
                todoTaskVM.updateExistingTask(taskName, taskDiscription, todoTaskVM.taskModel)
            }
        }
    }
}

extension TaskViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
}
