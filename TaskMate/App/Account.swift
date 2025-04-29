//
//  Account.swift
//  simpleLogin
//
//  Created by Adriel de Souza on 26/04/25.
//

import Foundation

struct Account: Codable {
    let fullName: String
    let email: String
    let password: String
    let birthDate: Date
    var tasks: [TaskItem]
}
