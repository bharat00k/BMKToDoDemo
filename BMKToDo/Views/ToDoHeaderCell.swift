//
//  ToDoHeaderCell.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 28/07/21.
//


import UIKit


//MARK:- You can code this calss in single file as well example in ToDoCell

class ToDoHeaderCell: UITableViewCell {
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var addTaskBtn: UIButton!
    
    func loadSectionData(_ sectionData: SectionModel)  {
        self.headerTitleLbl.text = sectionData.taskType
        self.addTaskBtn.tag      = sectionData.id
    }
    
}
