//
//  NewTaskViewController.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 05/05/25.
//

import UIKit

protocol AddEditTaskDelegate: AnyObject {
    func didAddOrEditTask()
}

class AddEditTaskViewController: UIViewController {
    var delegate: AddEditTaskDelegate?
    var taskID: UUID?

    private lazy var modalHeader: ModalHeaderView = {
        let header = ModalHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.headerText = "New Task"
        
        header.rightButtonText = "Add"
        header.rightButtonAction = handleTaskSubmit
        
        header.leftButtonText = "Cancel"
        header.leftButtonAction = { self.dismiss(animated: true) }

        return header
    }()

    private lazy var taskNameInput: LabeledTextField = {
        let input = LabeledTextField()
        input.labelText = "Task"
        input.borderStyle = .none
        input.cornerRadius = 8
        input.placeholder = "Your task name here"
        return input
    }()

    private lazy var categoryPicker: TaskCategorySelector = {
        TaskCategorySelector()
    }()

    private lazy var taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = Fonts.calloutSemibold
        label.textColor = .Label.primary
        return label
    }()

    private lazy var taskDescriptionTextArea: TextArea = {
        let input = TextArea()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.backgroundColor = UIColor.Background.tertiary
        input.layer.cornerRadius = 8
        input.font = Fonts.body
        input.placeholder = "More details about the task"

        input.heightAnchor.constraint(equalToConstant: 121).isActive = true

        return input
    }()
    
    private lazy var taskStatus: TaskStatusInput = {
        let input = TaskStatusInput()
        input.isHidden = true
        return input
    }()

    private lazy var taskDescriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [taskDescriptionLabel, taskDescriptionTextArea])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8

        return stack
    }()


    private lazy var formStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [taskNameInput, categoryPicker, taskStatus, taskDescriptionStack])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20

        return view
    }()
    
    private lazy var deleteTaskButton: UIButton = {
        let button = createRoundedButton(labelText: "Delete Task", backgroundColor: .Background.tertiary, textColor: .Colors.error, labelFont: Fonts.bodySemibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteTaskAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc func deleteTaskAction() {
        guard let taskID else {
            return
        }
        Persistance.deleteTaks(id: taskID)
        delegate?.didAddOrEditTask()
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .Background.secondary
    }

    func setData(task: TaskItem) {
        modalHeader.headerText = "Task Details"
        modalHeader.rightButtonText = "Done"

        taskID = task.id
        taskNameInput.text = task.name
        categoryPicker.selectedCategory = task.category
        taskStatus.isCompleted = task.isCompleted
        taskStatus.isHidden = false
        taskDescriptionTextArea.text = task.description
        taskDescriptionTextArea.placeholderIsHidden = task.description != nil && !task.description!.isEmpty
        
        deleteTaskButton.isHidden = false
    }
}

extension AddEditTaskViewController: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(modalHeader)
        view.addSubview(formStack)
        view.addSubview(deleteTaskButton)
    }

    func setupConstraints() {
        modalHeader.addSafeMargin(view)
        formStack.addSafeMargin(view)
        deleteTaskButton.addSafeMargin(view)

        NSLayoutConstraint.activate([
            modalHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formStack.topAnchor.constraint(equalTo: modalHeader.bottomAnchor, constant: 20),
            
            deleteTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
}

extension AddEditTaskViewController {
    @objc func handleTaskSubmit() {
        guard let name = taskNameInput.text, !name.isEmpty else {
            return
        }

        guard let category = categoryPicker.selectedCategory else {
            return
        }

        var task = TaskItem(
            name: name,
            description: taskDescriptionTextArea.text,
            isCompleted: taskStatus.isCompleted,
            category: category
        )

        if let taskID {
            task.id = taskID
            Persistance.replaceTask(task)
        } else {
            Persistance.addTask(task)
        }

        delegate?.didAddOrEditTask()

        dismiss(animated: true)
    }
}
