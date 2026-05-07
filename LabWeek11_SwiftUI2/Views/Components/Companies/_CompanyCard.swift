//
//  _CompanyCard.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI

struct _CompanyCard: View {
    let company: Company
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(company.name)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                
                Text(company.address)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text("Active Project: \(company.activeProjectCount)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.primary)
                    .padding(.top, 2)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(company.employeeCount)")
                    .font(.system(size: 14, weight: .bold))
                
                Image(systemName: "person.fill")
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    _CompanyCard(
        company: Company(
            name: "PT Ciputra Selalu Sehat Amin",
            address: "Boulevard Street"
        )
    )
    .padding()
}
