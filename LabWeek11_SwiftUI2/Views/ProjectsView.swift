//
//  ProjectsView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct ProjectsView: View {
    @Environment(\.modelContext) private var modelContext
    
    let company: Company
    
    @StateObject private var viewModel = ProjectViewModel()
    
    @State private var isShowingAddProject = false
    @State private var selectedProjectForEdit: Project?
    
    private var projects: [Project] {
        viewModel.projects(for: company)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 18) {
                headerView
                
                if projects.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(projects) { project in
                                _ProjectCard(project: project)
                                    .contextMenu {
                                        Button {
                                            selectedProjectForEdit = project
                                        } label: {
                                            Label("Update", systemImage: "pencil")
                                        }
                                        
                                        Button(role: .destructive) {
                                            viewModel.deleteProject(
                                                project: project,
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
        .sheet(isPresented: $isShowingAddProject) {
            ProjectFormView(company: company)
        }
        .sheet(item: $selectedProjectForEdit) { project in
            ProjectFormView(company: company, project: project)
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Text("Projects")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                isShowingAddProject = true
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
            
            Image(systemName: "folder")
                .font(.system(size: 38))
                .foregroundStyle(.secondary)
            
            Text("No Projects Yet")
                .font(.system(size: 18, weight: .bold))
            
            Text("Tap the plus button to add a project for this company.")
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
        ProjectsView(
            company: Company(
                name: "PT Ciputra Selalu Sehat Amin",
                address: "Boulevard Street"
            )
        )
    }
}
