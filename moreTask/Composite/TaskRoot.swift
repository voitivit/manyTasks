//
//  TaskRoot.swift
//  moreTask
//
//  Created by emil kurbanov on 08.10.2021.
//

import Foundation
class TaskRoot: TaskProtocol {
    
    internal var rootTask: TaskProtocol? = nil
    internal var taskName = "Список задач"
    internal var childTasks: [TaskProtocol] = []
    
    func addSubtask(subtask: TaskProtocol) {
        self.childTasks.append(subtask)
    }
}

