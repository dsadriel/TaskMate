//
//  ApplicationData.swift
//  simpleLogin
//
//  Created by Adriel de Souza on 28/04/25.
//

import Foundation


struct ApplicationData: Codable {
    var registeredAccounts: [Account]
    var loggedInAccount: Account?

    init() {
        registeredAccounts = []
        loggedInAccount = nil
    }

    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }

    static func fromData(_ data: Data) throws -> Self {
        try JSONDecoder().decode(Self.self, from: data)
    }
}
