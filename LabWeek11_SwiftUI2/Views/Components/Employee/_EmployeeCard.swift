//
//  _EmployeeCard.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI

struct _EmployeeCard: View {
    let employee: Employee
    
    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Color.blue.opacity(0.18))
                .frame(width: 42, height: 42)
                .overlay {
                    Text(employee.initials)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.blue)
                }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(employee.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                Text(employee.role)
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(spacing: 2) {
                Text("\(employee.projectCount)")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                
                Text("Projects")
                    .font(.system(size: 9))
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

#Preview {
    _EmployeeCard(
        employee: Employee(
            name: "Christian Besar",
            role: "AI Engineer"
        )
    )
    .padding()
}
