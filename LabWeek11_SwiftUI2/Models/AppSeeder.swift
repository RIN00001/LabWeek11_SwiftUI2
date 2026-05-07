//
//  AppSeeder.swift
//  LabWeek11_SwiftUI2
//
//  Created by student on 07/05/26.
//

import Foundation
import SwiftData

enum AppSeeder {
    static func seedSampleData(context: ModelContext) {
        let companyOne = Company(
            name: "PT Ciputra Selalu Sehat Amin",
            address: "Boulevard Street"
        )
        
        let companyTwo = Company(
            name: "PT Gacor Labs",
            address: "In Your Dream Street"
        )
        
        let jason = Employee(
            name: "Jason",
            role: "QA",
            company: companyOne
        )
        
        let christian = Employee(
            name: "Christian Besar",
            role: "AI Engineer",
            company: companyOne
        )
        
        let bryan = Employee(
            name: "Bryan Wewew",
            role: "Frontend Engineer",
            company: companyOne
        )
        
        let projectOne = Project(
            name: "E-learn Universitas Bukan UC",
            projectDescription: "Digitalisasi pembelajaran universitas yang bukan UC",
            startDate: makeDate(day: 29, month: 4, year: 2026),
            endDate: makeDate(day: 31, month: 5, year: 2026),
            company: companyOne,
            personInCharge: bryan
        )
        
        let projectTwo = Project(
            name: "Medicare",
            projectDescription: "Collaboration with MED and National Hospital",
            startDate: makeDate(day: 1, month: 4, year: 2026),
            endDate: makeDate(day: 30, month: 4, year: 2026),
            company: companyOne,
            personInCharge: jason
        )
        
        let projectThree = Project(
            name: "Stock Prediction",
            projectDescription: "Integrating machine learning with stock prediction",
            startDate: makeDate(day: 10, month: 4, year: 2026),
            endDate: makeDate(day: 16, month: 4, year: 2026),
            company: companyOne,
            personInCharge: jason
        )
        
        let projectFour = Project(
            name: "Deteksi Judi Online",
            projectDescription: "Kolaborasi sama Dosen UC",
            startDate: makeDate(day: 29, month: 10, year: 2025),
            endDate: makeDate(day: 1, month: 4, year: 2026),
            company: companyOne,
            personInCharge: christian
        )
        
        let companyTwoEmployee = Employee(
            name: "Admin Gacor",
            role: "Project Manager",
            company: companyTwo
        )
        
        companyOne.employees = [jason, christian, bryan]
        companyOne.projects = [projectOne, projectTwo, projectThree, projectFour]
        
        companyTwo.employees = [companyTwoEmployee]
        companyTwo.projects = []
        
        context.insert(companyOne)
        context.insert(companyTwo)
        
        do {
            try context.save()
        } catch {
            print("Failed to seed sample data: \(error.localizedDescription)")
        }
    }
    
    private static func makeDate(day: Int, month: Int, year: Int) -> Date {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components) ?? Date()
    }
}
