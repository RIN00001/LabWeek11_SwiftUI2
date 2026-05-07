//
//  LabWeek11_SwiftUI2App.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

@main
struct LabWeek11_SwiftUI2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            Company.self,
            Employee.self,
            Project.self
        ])
    }
}
