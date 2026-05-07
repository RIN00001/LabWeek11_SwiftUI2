//
//  Company.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData

@Model
final class Company {
    var name: String
    var address: String
    
    @Relationship(deleteRule: .cascade, inverse: \Employee.company)
    var employees: [Employee]
    
    @Relationship(deleteRule: .cascade, inverse: \Project.company)
    var projects: [Project]
    
    init(
        name: String,
        address: String,
        employees: [Employee] = [],
        projects: [Project] = []
    ) {
        self.name = name
        self.address = address
        self.employees = employees
        self.projects = projects
    }
    
    var employeeCount: Int {
        employees.count
    }
    
    var activeProjectCount: Int {
        projects.filter { $0.isActive }.count
    }
}
