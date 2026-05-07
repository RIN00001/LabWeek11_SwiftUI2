//
//  _ProjectCard.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI

struct _ProjectCard: View {
    let project: Project
    
    private var statusColor: Color {
        project.isActive ? .blue : .green
    }
    
    private var formattedDateRange: String {
        "\(project.startDate.formattedProjectDate) - \(project.endDate.formattedProjectDate)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(project.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    
                    Text(project.projectDescription)
                        .font(.system(size: 11))
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Text(project.statusText)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(statusColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(statusColor.opacity(0.15))
                    )
            }
            
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                
                Text(formattedDateRange)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
            
            HStack(spacing: 6) {
                Image(systemName: project.personInCharge == nil ? "person.crop.circle.badge.questionmark" : "person.fill")
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                
                Text(project.personInChargeName)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 13)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

private extension Date {
    var formattedProjectDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self)
    }
}

#Preview {
    _ProjectCard(
        project: Project(
            name: "E-learn Universitas Bukan UC",
            projectDescription: "Digitalisasi pembelajaran universitas yang bukan UC",
            startDate: Date(),
            endDate: Date()
        )
    )
    .padding()
}
