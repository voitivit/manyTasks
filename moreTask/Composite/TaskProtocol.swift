//
//  TaskProtocol.swift
//  moreTask
//
//  Created by emil kurbanov on 08.10.2021.
//

import Foundation
protocol TaskProtocol {
    
    var rootTask: TaskProtocol? {get}
    var taskName: String { get }
    var childTasks: [TaskProtocol] { get }
    
    func addSubtask( subtask: TaskProtocol)
}
