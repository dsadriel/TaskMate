//
//  Task.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 05/05/25.
//

import Foundation

struct TaskItem: Codable {
    var id = UUID()
    let name: String
    let description: String?
    var isCompleted: Bool
    let category: TaskCategory
}
