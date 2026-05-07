//
//  ProjectViewModel.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData
import Combine

@MainActor
final class ProjectViewModel: ObservableObject {
    
    func addProject(
        name: String,
        description: String,
        startDate: Date,
        endDate: Date,
        personInCharge: Employee?,
        company: Company,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedDescription.isEmpty else {
            return
        }
        
        let project = Project(
            name: trimmedName,
            projectDescription: trimmedDescription,
            startDate: startDate,
            endDate: endDate,
            company: company,
            personInCharge: personInCharge
        )
        
        company.projects.append(project)
        personInCharge?.projects.append(project)
        
        context.insert(project)
        save(context)
    }
    
    func updateProject(
        project: Project,
        name: String,
        description: String,
        startDate: Date,
        endDate: Date,
        personInCharge: Employee?,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedDescription.isEmpty else {
            return
        }
        
        let previousEmployee = project.personInCharge
        
        if previousEmployee != personInCharge {
            previousEmployee?.projects.removeAll { $0 == project }
            personInCharge?.projects.append(project)
        }
        
        project.name = trimmedName
        project.projectDescription = trimmedDescription
        project.startDate = startDate
        project.endDate = endDate
        project.personInCharge = personInCharge
        
        save(context)
    }
    
    func deleteProject(
        project: Project,
        context: ModelContext
    ) {
        project.personInCharge?.projects.removeAll { $0 == project }
        context.delete(project)
        save(context)
    }
    
    func projects(for company: Company) -> [Project] {
        company.projects.sorted {
            $0.endDate < $1.endDate
        }
    }
    
    func activeStatus(for project: Project) -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let deadline = calendar.startOfDay(for: project.endDate)
        
        return today <= deadline
    }
    
    private func save(_ context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Project save error: \(error.localizedDescription)")
        }
    }
}
