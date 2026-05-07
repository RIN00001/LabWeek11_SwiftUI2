//
//  CompaniesView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct CompaniesView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Company.name, order: .forward)
    private var companies: [Company]
    
    @StateObject private var viewModel = CompanyViewModel()
    
    @State private var isShowingAddCompany = false
    @State private var selectedCompanyForEdit: Company?
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 18) {
                headerView
                
                Button("Seed Sample Data") {
                    AppSeeder.seedSampleData(context: modelContext)
                }
                .font(.system(size: 14, weight: .semibold))
                
                if companies.isEmpty {
                    emptyStateView
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 14) {
                            ForEach(companies) { company in
                                NavigationLink {
                                    CompanyDetailView(company: company)
                                } label: {
                                    _CompanyCard(company: company)
                                }
                                .buttonStyle(.plain)
                                .contextMenu {
                                    Button {
                                        selectedCompanyForEdit = company
                                    } label: {
                                        Label("Update", systemImage: "pencil")
                                    }
                                    
                                    Button(role: .destructive) {
                                        viewModel.deleteCompany(
                                            company: company,
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
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingAddCompany) {
            CompanyFormView()
        }
        .sheet(item: $selectedCompanyForEdit) { company in
            CompanyFormView(company: company)
        }
    }
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Text("Companies")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                isShowingAddCompany = true
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
            
            Image(systemName: "building.2")
                .font(.system(size: 38))
                .foregroundStyle(.secondary)
            
            Text("No Companies Yet")
                .font(.system(size: 18, weight: .bold))
            
            Text("Tap the plus button to add your first company.")
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
        CompaniesView()
    }
}
