//
//  SectionModel.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//


import CoreData

struct SectionModel {
    let taskType: String
    let id: Int
    let data : [TodoTask]

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> String {
        if let name  = data[index].name {
            return name
        }
        return ""
    }
}

extension SectionModel {
    //  Putting a new init method here means we can
    //  keep the original, memberwise initaliser.
    init(taskType: String, id: Int, data: TodoTask...) {
        self.taskType = taskType
        self.id    = id
        self.data  = data
    }
}

