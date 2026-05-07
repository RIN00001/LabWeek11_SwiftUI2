//
//  EmployeeFormView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct EmployeeFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = EmployeeViewModel()
    
    let company: Company
    let employee: Employee?
    
    @State private var name: String
    @State private var role: String
    
    private var isEditing: Bool {
        employee != nil
    }
    
    init(company: Company, employee: Employee? = nil) {
        self.company = company
        self.employee = employee
        
        _name = State(initialValue: employee?.name ?? "")
        _role = State(initialValue: employee?.role ?? "")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 22) {
                    headerView
                    
                    VStack(spacing: 16) {
                        formField(
                            title: "Employee Name",
                            placeholder: "Enter employee name",
                            text: $name
                        )
                        
                        formField(
                            title: "Role",
                            placeholder: "Enter employee role",
                            text: $role
                        )
                    }
                    .padding(.horizontal, 22)
                    
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 38, height: 38)
            }
            
            Spacer()
            
            Text(isEditing ? "Update Employee" : "New Employee")
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            Button {
                saveEmployee()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(canSave ? .blue : .gray)
                    .frame(width: 38, height: 38)
            }
            .disabled(!canSave)
        }
        .padding(.horizontal, 14)
        .padding(.top, 10)
    }
    
    private func formField(
        title: String,
        placeholder: String,
        text: Binding<String>
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
            
            TextField(placeholder, text: text)
                .font(.system(size: 15))
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBackground))
                )
        }
    }
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !role.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func saveEmployee() {
        if let employee {
            viewModel.updateEmployee(
                employee: employee,
                name: name,
                role: role,
                context: modelContext
            )
        } else {
            viewModel.addEmployee(
                name: name,
                role: role,
                company: company,
                context: modelContext
            )
        }
        
        dismiss()
    }
}

#Preview {
    EmployeeFormView(
        company: Company(
            name: "PT Ciputra Selalu Sehat Amin",
            address: "Boulevard Street"
        )
    )
}
