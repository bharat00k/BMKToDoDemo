//
//  TodoListViewModel.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//


import Foundation




class TodoListViewModel {
    
    var todoSectionDataList: [SectionModel]
    
    init() {
        todoSectionDataList = [SectionModel]()
    }
    
    func refershTodoList() ->  [SectionModel] {
        return TodoCoreDataModel().getSavedDataFromCoreData()
    }
   
    func getTodoHeaderObject(_ section: Int) -> SectionModel {
        
        return self.todoSectionDataList[section]
    }
   
    var numberOFSections: Int {
        return todoSectionDataList.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.todoSectionDataList[section].numberOfItems
    }
    
    func todoTaskAtIndex(_ section: Int, _ index: Int) -> TodoTask {
        let todoTaskData = self.todoSectionDataList[section].data[index]
        return todoTaskData
    }
    
    func getSectionID(_ section: Int) -> Int {
        return self.todoSectionDataList[section].id
    }
    
    func deleteTodoItemFromList(_ managedObject: TodoTask)  {
        TodoCoreDataModel().deleteEntityData(managedObject)
        todoSectionDataList = refershTodoList()
    }
    
    //Here you can add more mothods or property that need in your controller
}



