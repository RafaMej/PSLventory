//
//  LoansView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI

struct LoansView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State private var selectedSegment = 0
    
    var activeLoans: [Loan] {
        firebaseManager.loans.filter { $0.isActive }
    }
    
    var returnedLoans: [Loan] {
        firebaseManager.loans.filter { !$0.isActive }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Estado", selection: $selectedSegment) {
                    Text("Activos (\(activeLoans.count))").tag(0)
                    Text("Devueltos (\(returnedLoans.count))").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    if selectedSegment == 0 {
                        ForEach(activeLoans) { loan in
                            ActiveLoanRowView(loan: loan)
                        }
                    } else {
                        ForEach(returnedLoans) { loan in
                            ReturnedLoanRowView(loan: loan)
                        }
                    }
                }
            }
            .navigationTitle("Préstamos")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
