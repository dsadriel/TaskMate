//
//  TasksListViewController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 05/05/25.
//

import UIKit

class TaskListViewController: UIViewController {
    private var tableSections: [TaskCategory] = []
    private var tableRows: [[TaskItem]] = []
    
    // MARK: - UI Elements

    private lazy var addTaskButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")?.withTintColor(
            UIColor.Colors.accent
        )
        button.tintColor = .Colors.accent
        button.target = self
        button.action = #selector(showNewTaskModal)

        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.register(TaskSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TaskSectionHeaderView.reuseIdentifier)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private lazy var emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.buttonAction = { [weak self] in
            self?.showNewTaskModal()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

        navigationItem.title = "Tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addTaskButton

        buildTableData()
        tableView.reloadData()
    }
}

extension TaskListViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
    }

    func setupConstraints() {
        emptyStateView.addSafeMargin(view)
        NSLayoutConstraint.activate([
            emptyStateView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

// MARK: Add task action
extension TaskListViewController {
    @objc func showNewTaskModal() {
        let newTaskViewController = AddEditTaskViewController()
        newTaskViewController.modalPresentationStyle = .pageSheet
        newTaskViewController.delegate = self
        present(newTaskViewController, animated: true)
    }
}

// MARK: UITableViewDataSource
extension TaskListViewController: UITableViewDataSource {
    func buildSectionsData() {
        var sections: [TaskCategory] = []
        let tasks: [TaskItem] = Persistance.getTasks()

        for category in TaskCategory.allCases where tasks.contains(where: { $0.category == category }) {
            sections.append(category)
        }

        tableSections = sections
    }

    func buildRowsData() {
        var rows: [[TaskItem]] = []
        let tasks: [TaskItem] = Persistance.getTasks()

        for sectionCategory in tableSections {
            rows.append(tasks.filter { $0.category == sectionCategory })
        }

        tableRows = rows
    }

    func buildTableData() {
        buildSectionsData()
        buildRowsData()
    }

    func getTaskByIndexPath(_ indexPath: IndexPath) -> TaskItem {
        tableRows[indexPath.section][indexPath.row]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.isHidden = tableSections.isEmpty
        emptyStateView.isHidden = !tableView.isHidden
        return tableSections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskSectionHeaderView.reuseIdentifier) as? TaskSectionHeaderView else {
            return UIView()
        }
        
        header.config(with: tableSections[section])
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
    -> Int
    {
        tableRows[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        cell.config(with: getTaskByIndexPath(indexPath)) {
            let task = self.getTaskByIndexPath(indexPath)
            cell.isCompleted.toggle()
            Persistance.toggleTaskCompletion(id: task.id)
            self.buildRowsData()
        }

        return cell
    }
}

extension TaskListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let editTaskViewController = AddEditTaskViewController()
        editTaskViewController.setData(task: getTaskByIndexPath(indexPath))
        editTaskViewController.modalPresentationStyle = .pageSheet
        editTaskViewController.delegate = self
        present(editTaskViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete")
        {[weak self] _, _, completionHandler in
            if let taskToDelete = self?.getTaskByIndexPath(indexPath) {
                Persistance.deleteTaks(id: taskToDelete.id)
            }

            self?.buildTableData()
            tableView.reloadData()

            completionHandler(true)
        }

        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: NewTaskDelegate
extension TaskListViewController: AddEditTaskDelegate {
    func didAddOrEditTask() {
        buildTableData()
        tableView.reloadData()
    }
}
