//
//  CompanyDetailView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI

struct CompanyDetailView: View {
    let company: Company
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 22) {
                titleView
                
                VStack(spacing: 14) {
                    NavigationLink {
                        EmployeesView(company: company)
                    } label: {
                        menuCard(
                            icon: "person.3.fill",
                            iconColor: .blue,
                            title: "Employees",
                            subtitle: "\(company.employees.count) items"
                        )
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink {
                        ProjectsView(company: company)
                    } label: {
                        menuCard(
                            icon: "folder.fill",
                            iconColor: .green,
                            title: "Projects",
                            subtitle: "\(company.projects.count) items"
                        )
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 18)
        }
        .navigationTitle(company.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var titleView: some View {
        Text(company.name)
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .center)
            .opacity(0)
            .frame(height: 1)
    }
    
    private func menuCard(
        icon: String,
        iconColor: Color,
        title: String,
        subtitle: String
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(iconColor)
                .frame(width: 34)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 16)
        .frame(height: 68)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    NavigationStack {
        CompanyDetailView(
            company: Company(
                name: "PT Ciputra Selalu Sehat Amin",
                address: "Boulevard Street"
            )
        )
    }
}
