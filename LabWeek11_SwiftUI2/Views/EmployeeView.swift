//
//  EmployeeView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct EmployeesView: View {
    @Environment(\.modelContext) private var modelContext
    
    let company: Company
    
    @StateObject private var viewModel = EmployeeViewModel()
    
    @State private var isShowingAddEmployee = false
    @State private var selectedEmployeeForEdit: Employee?
    
    private var employees: [Employee] {
        viewModel.employees(for: company)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 18) {
                headerView
                
                if employees.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(employees) { employee in
                                _EmployeeCard(employee: employee)
                                    .contextMenu {
                                        Button {
                                            selectedEmployeeForEdit = employee
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        
                                        Button(role: .destructive) {
                                            viewModel.deleteEmployee(
                                                employee: employee,
                                                context: modelContext
                                            )
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding(.bottom, 24)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingAddEmployee) {
            EmployeeFormView(company: company)
        }
        .sheet(item: $selectedEmployeeForEdit) { employee in
            EmployeeFormView(company: company, employee: employee)
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Text("Employees")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                isShowingAddEmployee = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.primary)
                    .frame(width: 42, height: 42)
                    .background(
                        Circle()
                            .fill(Color(.secondarySystemBackground))
                    )
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 10) {
            Spacer()
            
            Image(systemName: "person.3")
                .font(.system(size: 38))
                .foregroundStyle(.secondary)
            
            Text("No Employees Yet")
                .font(.system(size: 18, weight: .bold))
            
            Text("Tap the plus button to add an employee for this company.")
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        EmployeesView(
            company: Company(
                name: "PT Ciputra Selalu Sehat Amin",
                address: "Boulevard Street"
            )
        )
    }
}
