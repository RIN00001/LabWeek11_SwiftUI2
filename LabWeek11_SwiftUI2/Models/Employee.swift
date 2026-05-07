//
//  Employee.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData

@Model
final class Employee {
    var name: String
    var role: String
    
    var company: Company?
    
    @Relationship(deleteRule: .nullify, inverse: \Project.personInCharge)
    var projects: [Project]
    
    init(
        name: String,
        role: String,
        company: Company? = nil,
        projects: [Project] = []
    ) {
        self.name = name
        self.role = role
        self.company = company
        self.projects = projects
    }
    
    var initials: String {
        let words = name.split(separator: " ")
        
        if words.count >= 2 {
            let first = words[0].prefix(1)
            let second = words[1].prefix(1)
            return "\(first)\(second)".uppercased()
        }
        
        return String(name.prefix(1)).uppercased()
    }
    
    var projectCount: Int {
        projects.count
    }
}
