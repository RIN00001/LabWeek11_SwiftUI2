//
//  CompanyFormView.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import SwiftUI
import SwiftData

struct CompanyFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @StateObject private var viewModel = CompanyViewModel()
    
    let company: Company?
    
    @State private var name: String
    @State private var address: String
    
    private var isEditing: Bool {
        company != nil
    }
    
    init(company: Company? = nil) {
        self.company = company
        
        _name = State(initialValue: company?.name ?? "")
        _address = State(initialValue: company?.address ?? "")
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
                            title: "Company Name",
                            placeholder: "Enter company name",
                            text: $name
                        )
                        
                        formField(
                            title: "Address",
                            placeholder: "Enter company address",
                            text: $address
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
            
            Text(isEditing ? "Update Company" : "New Company")
                .font(.system(size: 18, weight: .bold))
            
            Spacer()
            
            Button {
                saveCompany()
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
        !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private func saveCompany() {
        if let company {
            viewModel.updateCompany(
                company: company,
                name: name,
                address: address,
                context: modelContext
            )
        } else {
            viewModel.addCompany(
                name: name,
                address: address,
                context: modelContext
            )
        }
        
        dismiss()
    }
}

#Preview {
    CompanyFormView()
}
