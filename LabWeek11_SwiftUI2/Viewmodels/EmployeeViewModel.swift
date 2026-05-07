//
//  EmployeeViewModel.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData
import Combine

@MainActor
final class EmployeeViewModel: ObservableObject {
    
    func addEmployee(
        name: String,
        role: String,
        company: Company,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedRole = role.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedRole.isEmpty else {
            return
        }
        
        let employee = Employee(
            name: trimmedName,
            role: trimmedRole,
            company: company
        )
        
        company.employees.append(employee)
        context.insert(employee)
        
        save(context)
    }
    
    func updateEmployee(
        employee: Employee,
        name: String,
        role: String,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedRole = role.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedRole.isEmpty else {
            return
        }
        
        employee.name = trimmedName
        employee.role = trimmedRole
        
        save(context)
    }
    
    func deleteEmployee(
        employee: Employee,
        context: ModelContext
    ) {
        for project in employee.projects {
            project.personInCharge = nil
        }
        
        context.delete(employee)
        save(context)
    }
    
    func employees(for company: Company) -> [Employee] {
        company.employees.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }
    
    private func save(_ context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Employee save error: \(error.localizedDescription)")
        }
    }
}
