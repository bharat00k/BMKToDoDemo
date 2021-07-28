//
//  ToDoCell.swift
//  BMKToDo
//
//  Created by Bharat Khatke on 27/07/21.
//


import UIKit
import CoreData

class ToDoCell: UITableViewCell {
    
    //MARK:- You can add more components here- We use custom cell here for enhacement of adiitional components
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func loadTaskCellData(_ cellData: TodoTask)  {
        self.titleLbl.text = cellData.name
        self.descriptionLbl.text = cellData.descriptions
    }
    
}
