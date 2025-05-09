//
//  TaskCategory.swift
//  TaskMate
//
//  Created by Adriel de Souza on 06/05/25.
//


enum TaskCategory: String, Codable, CaseIterable {
    case education = "Education"
    case fitness = "Fitness"
    case groceries = "Groceries"
    case health = "Health"
    case home = "Home"
    case personal = "Personal"
    case reading = "Reading"
    case shopping = "Shopping"
    case travel = "Travel"

    var imageName: String  {
        switch self {
        case .education:
            return "graduationcap.fill"
        case .fitness:
            return "dumbbell.fill"
        case .groceries:
            return "fork.knife"
        case .health:
            return "pills.fill"
        case .home:
            return "house.fill"
        case .personal:
            return "person.fill"
        case .reading:
            return "book.fill"
        case .shopping:
            return "cart.fill"
        case .travel:
            return "airplane"
        }
    }
}
