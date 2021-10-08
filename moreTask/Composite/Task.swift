//
//  Task.swift
//  moreTask
//
//  Created by emil kurbanov on 08.10.2021.
//

import Foundation
class Task: TaskProtocol {
    
    internal var rootTask: TaskProtocol?
    internal var taskName: String
    internal var childTasks: [TaskProtocol] = []
    
    init(taskName: String, rootTask: TaskProtocol?) {
        self.taskName = taskName
        self.rootTask = rootTask
    }
    
    func addSubtask(subtask: TaskProtocol) {
        self.childTasks.append(subtask)
    }
}
