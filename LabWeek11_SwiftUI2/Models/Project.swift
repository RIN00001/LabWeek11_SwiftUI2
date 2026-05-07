//
//  Project.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData

@Model
final class Project {
    var name: String
    var projectDescription: String
    var startDate: Date
    var endDate: Date
    
    var company: Company?
    var personInCharge: Employee?
    
    init(
        name: String,
        projectDescription: String,
        startDate: Date,
        endDate: Date,
        company: Company? = nil,
        personInCharge: Employee? = nil
    ) {
        self.name = name
        self.projectDescription = projectDescription
        self.startDate = startDate
        self.endDate = endDate
        self.company = company
        self.personInCharge = personInCharge
    }
    
    var isActive: Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let deadline = calendar.startOfDay(for: endDate)
        
        return today <= deadline
    }
    
    var statusText: String {
        isActive ? "Active" : "Completed"
    }
    
    var personInChargeName: String {
        personInCharge?.name ?? "Unassigned"
    }
}
