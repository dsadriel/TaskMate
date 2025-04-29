//
//  Fonts.swift
//  simpleLogin
//
//  Created by Adriel de Souza on 25/04/25.
//

import Foundation

struct Persistance {
    private static let applicationDataKey = "appData"

    // MARK: Generic aplication data

    static func getApplicaitonData() -> ApplicationData {
        if let data = UserDefaults.standard.value(forKey: applicationDataKey) as? Data {
            do {
                return try ApplicationData.fromData(data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return ApplicationData()
    }

    static func saveApplicaitonData(_ appData: ApplicationData) {
        var appData = appData

        // Updates logged account data before saving
        if let loggedInAccount = appData.loggedInAccount {
            appData.registeredAccounts.removeAll { $0.email == loggedInAccount.email }
            appData.registeredAccounts.append(loggedInAccount)
        }

        do {
            let encodedData = try appData.toData()
            UserDefaults.standard.set(encodedData, forKey: applicationDataKey)
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: Account handeling
    static func registerAccount(_ account: Account) {
        var appData = getApplicaitonData()
        appData.registeredAccounts.append(account)

        Self.saveApplicaitonData(appData)
    }


    private static func setLoggedInUser(_ user: Account?) {
        var appData = Self.getApplicaitonData()
        appData.loggedInAccount = user
        Self.saveApplicaitonData(appData)
    }

    static func isRegistered(_ email: String) -> Bool {
        getApplicaitonData().registeredAccounts.contains { $0.email == email }
    }

    static func login(email: String, password: String) -> Bool {
        guard let account = getApplicaitonData().registeredAccounts.first(where: { $0.email == email && $0.password == password }) else {
            // Account not found
            return false
        }

        Self.setLoggedInUser(account)
        return true
    }

    static func logout() {
        Self.setLoggedInUser(nil)
    }

    static func deleteAccount(email: String){
        var accountList = getApplicaitonData().registeredAccounts
        
        if let index = accountList.firstIndex(where: { $0.email == email }) {
            accountList.remove(at: index)
            
            if email == getApplicaitonData().loggedInAccount?.email{
                Self.setLoggedInUser(nil)
            }
            
            var appData = ApplicationData()
            appData.registeredAccounts = accountList
            
            Self.saveApplicaitonData(appData)
        }
    }

    // MARK: Tasks handeling

    static func addTask(_ task: TaskItem) {
        var appData = Self.getApplicaitonData()
        appData.loggedInAccount?.tasks.append(task)
        Self.saveApplicaitonData(appData)
    }

    static func deleteTaks(id: UUID){
        var appData = Self.getApplicaitonData()
        appData.loggedInAccount?.tasks.removeAll { $0.id == id }
        Self.saveApplicaitonData(appData)
    }

    static func toggleTaskCompletion( id: UUID) {
        var appData = Self.getApplicaitonData()
        if let index = appData.loggedInAccount?.tasks.firstIndex(where: { $0.id == id }) {     
            let task = appData.loggedInAccount?.tasks[index]
            
            guard var task else {
                return
            }
            
            task.isCompleted.toggle()

            appData.loggedInAccount?.tasks[index] = task
        }
        
        Self.saveApplicaitonData(appData)
    }
    
    static func replaceTask(_ task: TaskItem) {
        var appData = Self.getApplicaitonData()
        if let index = appData.loggedInAccount?.tasks.firstIndex(where: { $0.id == task.id }) {
            appData.loggedInAccount?.tasks[index] = task
        }
        Self.saveApplicaitonData(appData)
    }

    static func getTasks() -> [TaskItem] {
        getApplicaitonData().loggedInAccount?.tasks ?? []
    }
}
