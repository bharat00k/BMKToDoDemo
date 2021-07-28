//
//  TodoCoreDataModel.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//


import UIKit
import CoreData


class TodoCoreDataModel {
    
    //MARK:- get List of saved data from CoreData here
     func getSavedDataFromCoreData() -> [SectionModel] {
        
        let todayTaskData    =  self.getTaskDataList("today")
        let tomorrowTaskData =  self.getTaskDataList("tomorrow")
        let upcomingTaskData =  self.getTaskDataList("upcoming")
        
        let section1 = SectionModel(taskType: "Today", id: 1, data: todayTaskData)
        let section2 = SectionModel(taskType: "Tomorrow", id: 2, data: tomorrowTaskData)
        let section3 = SectionModel(taskType: "Upcoming", id: 3, data: upcomingTaskData)
        
        return [section1, section2, section3]
    }
    
    //MARK:- Insert user data in Coredata
    func insertNewEntryInDatabase(_ taskName: String, _ taskDiscription: String, _ taskType: String)  {
        let newobject = TodoTask(context: globalContext)
        newobject.name = taskName
        newobject.date = Date()
        newobject.descriptions = taskDiscription
        newobject.taskType = taskType
        saveContextValue()
    }
    
    //MARK:- Update existing Entry here
    func updateExistingEntry(_ taskName: String, _ taskDiscription: String, _ managaedObject: TodoTask?)  {
        if let object = managaedObject {
            object.name = taskName
            object.descriptions = taskDiscription
        }
        saveContextValue()
    }
    
    
    //MARK:- Get task List data here
    func getTaskDataList(_ taskType: String) -> [TodoTask] {
        var taskList = [TodoTask]()
        
        let request: NSFetchRequest<TodoTask> = TodoTask.fetchRequest()
        request.predicate = NSPredicate(format: "taskType CONTAINS[cd] %@", taskType)
        
        do  {
            taskList =  try globalContext.fetch(request)
        }
        catch {
            print("Error while fetching data: \(error)")
        }
        
        return taskList
    }
    
    //MARK:- Delete Core Data Entity
    
    func deleteEntityData( _ managedObject: TodoTask)  {
        globalContext.delete(managedObject)
        saveContextValue()
    }
    
    //MARK:- Save Context
    func saveContextValue()  {
        do {
            try globalContext.save()
        }catch {
            print("Error saving context :- \(error)")
        }
    }
}



