//
//  TaskCell.swift
//  moreTask
//
//  Created by emil kurbanov on 08.10.2021.
//

import UIKit

class TaskCell: UITableViewCell {
static let reuseIdentifier = "TaskCell"

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var subTaskLabel: UILabel!
}
