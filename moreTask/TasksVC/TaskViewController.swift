//
//  TaskViewController.swift
//  moreTask
//
//  Created by emil kurbanov on 08.10.2021.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addBtnTapped(_ sender: Any) {
        showAlertAddTask()
    }
    private let addTaskAlertTitle = "Создайте задачу"
    private let addTaskAlertMessage = "Введите подзадачу"
    private let addTaskAlertSuccess = "Создать"
    private let addTaskAlertCancel = "Отмена"
    
    private var currentTask: TaskProtocol = TaskRoot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func configureViews() {
        
        let title = currentTask.taskName
        self.navigationItem.title = title
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TaskViewController,
            let selectedTask = sender as? TaskProtocol else {return}
        destination.currentTask = selectedTask
    }
    
    private func showAlertAddTask() {
        let alert = UIAlertController(title: addTaskAlertTitle, message: addTaskAlertMessage, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Название задачи"
        }
        
        let actionSuccess = UIAlertAction(title: addTaskAlertSuccess, style: .default, handler: { [weak self] (_) in
            guard let textField = alert.textFields?[0],
                let taskName = textField.text,
                !(alert.textFields?[0].text?.isEmpty ?? false) else { return }
            self?.addTask(name: taskName)
        })
        
        let actionCancel = UIAlertAction(title: addTaskAlertCancel, style: .cancel, handler: nil)
        
        alert.addAction(actionSuccess)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addTask(name: String) {
        let task = Task(taskName: name, rootTask: currentTask)
        currentTask.addSubtask(subtask: task)
        tableView.reloadData()
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTask.childTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as? TaskCell else {return UITableViewCell()}
        let task = currentTask.childTasks[indexPath.row]
        
        cell.taskLabel.text = task.taskName
        cell.subTaskLabel.text = "Подзадач: \(task.childTasks.count)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = currentTask.childTasks[indexPath.row]
        performSegue(withIdentifier: "showSubtasks", sender: sender)
    }
    
}

