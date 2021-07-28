//
//  TodoViewModel.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//

import Foundation
import CoreData

struct TodoViewModel {
    
    let taskModel: TodoTask?
    let currentTaskID: Int
    let isUpdate: Bool
    
    init(_ taskModel: TodoTask?, _ taskID: Int, _ isUpdate: Bool) {
        self.taskModel = taskModel
        self.currentTaskID = taskID
        self.isUpdate = isUpdate
    }
    
    // get necessory properties here
    
    var taskName: String {
        return taskModel?.name ?? ""
    }
    
    var descriptionText: String {
        return taskModel?.descriptions ?? ""
    }
    
    var taskType: String {
        return taskModel?.taskType ?? ""
    }
    
    var isUpdateFlag: Bool {
        return self.isUpdate
    }
    
    var getTaskID: Int {
        return self.currentTaskID
    }
    
    //Methods
    func getTaskType() -> String {
        var taskType = ""
        switch self.currentTaskID {
        case 1:
            taskType = "today"
        case 2:
            taskType = "tomorrow"
            
        case 3:
            taskType = "upcoming"
        default:
            break
        }
        
        return taskType
    }
    
    func updateExistingTask(_ taskName: String, _ taskDescription: String, _ managedObject: TodoTask?)  {
        TodoCoreDataModel().updateExistingEntry(taskName, taskDescription, managedObject)
    }
    
    func addNewTodoTask(_ taskName: String, _ taskDiscription: String, _ taskType: String)  {
        TodoCoreDataModel().insertNewEntryInDatabase(taskName, taskDiscription, taskType)
    }
}
