//
//  CompanyViewModel.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData
import Combine

@MainActor
final class CompanyViewModel: ObservableObject {
    
    func addCompany(
        name: String,
        address: String,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedAddress.isEmpty else {
            return
        }
        
        let company = Company(
            name: trimmedName,
            address: trimmedAddress
        )
        
        context.insert(company)
        save(context)
    }
    
    func updateCompany(
        company: Company,
        name: String,
        address: String,
        context: ModelContext
    ) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty, !trimmedAddress.isEmpty else {
            return
        }
        
        company.name = trimmedName
        company.address = trimmedAddress
        
        save(context)
    }
    
    func deleteCompany(
        company: Company,
        context: ModelContext
    ) {
        context.delete(company)
        save(context)
    }
    
    private func save(_ context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Company save error: \(error.localizedDescription)")
        }
    }
}
