//
//  ProjectFormView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct ProjectFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = ProjectViewModel()
    
    let company: Company
    let project: Project?
    
    @State private var name: String
    @State private var description: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var selectedEmployee: Employee?
    
    private var employees: [Employee] {
        company.employees.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }
    
    private var isEditing: Bool {
        project != nil
    }
    
    init(company: Company, project: Project? = nil) {
        self.company = company
        self.project = project
        
        _name = State(initialValue: project?.name ?? "")
        _description = State(initialValue: project?.projectDescription ?? "")
        _startDate = State(initialValue: project?.startDate ?? Date())
        _endDate = State(initialValue: project?.endDate ?? Date())
        _selectedEmployee = State(initialValue: project?.personInCharge)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 22) {
                        headerView
                        
                        VStack(alignment: .leading, spacing: 10) {
                            sectionTitle("Project Information")
                            projectInformationCard
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            sectionTitle("Person In Charge")
                            personInChargeCard
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 12)
                    .padding(.bottom, 30)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.primary)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color(.systemBackground)))
            }
            
            Spacer()
            
            Text(isEditing ? "Edit Project" : "New Project")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                saveProject()
            } label: {
                Image(systemName: "checkmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(canSave ? .primary : .secondary)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Color(.systemBackground)))
            }
            .disabled(!canSave)
        }
    }
    
    // MARK: - Sections
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 4)
    }
    
    private var projectInformationCard: some View {
        VStack(spacing: 0) {
            TextField("Project Name", text: $name)
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .frame(height: 54)
            
            Divider()
                .padding(.horizontal, 16)
            
            TextField("Enter project description...", text: $description, axis: .vertical)
                .font(.system(size: 16))
                .lineLimit(3...5)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .frame(minHeight: 110, alignment: .topLeading)
            
            Divider()
                .padding(.horizontal, 16)
            
            dateRow(title: "Start Date", selection: $startDate)
            
            Divider()
                .padding(.horizontal, 16)
            
            dateRow(title: "End Date", selection: $endDate)
        }
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(.systemBackground))
        )
    }
    
    private var personInChargeCard: some View {
        Menu {
            Button("Unassigned") {
                selectedEmployee = nil
            }
            
            ForEach(employees) { employee in
                Button(employee.name) {
                    selectedEmployee = employee
                }
            }
        } label: {
            HStack {
                Text("Select Employee")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Text(selectedEmployee?.name ?? "None")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.systemBackground))
            )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Rows
    
    private func dateRow(title: String, selection: Binding<Date>) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.primary)
            
            Spacer()
            
            DatePicker(
                "",
                selection: selection,
                displayedComponents: .date
            )
            .labelsHidden()
            .datePickerStyle(.compact)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color(.systemGray6))
            )
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
    }
    
    // MARK: - Save
    
    private var canSave: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        startDate <= endDate
    }
    
    private func saveProject() {
        if let project {
            viewModel.updateProject(
                project: project,
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                personInCharge: selectedEmployee,
                context: modelContext
            )
        } else {
            viewModel.addProject(
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                personInCharge: selectedEmployee,
                company: company,
                context: modelContext
            )
        }
        
        dismiss()
    }
}

#Preview {
    ProjectFormView(
        company: Company(
            name: "PT Ciputra Selalu Sehat Amin",
            address: "Boulevard Street"
        ),
        project: Project(
            name: "E-learn Universitas Bukan UC",
            projectDescription: "Digitalisasi pembelajaran universitas yang bukan UC",
            startDate: Date(),
            endDate: Date()
        )
    )
}
