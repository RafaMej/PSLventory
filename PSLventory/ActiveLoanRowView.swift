//
//  ActiveLoanRowView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI

struct ActiveLoanRowView: View {
    let loan: Loan
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var daysLent: Int {
        Calendar.current.dateComponents([.day], from: loan.loanDate, to: Date()).day ?? 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(loan.itemName)
                        .font(.headline)
                    
                    Text(loan.borrowerName)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Text(loan.borrowerEmail)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(daysLent) días")
                        .font(.caption)
                        .foregroundColor(daysLent > 30 ? .red : .secondary)
                    
                    Button("Devolver") {
                        if let loanId = loan.id {
                            firebaseManager.returnItem(loanId: loanId)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                }
            }
            
            Text("Prestado: \(loan.loanDate, formatter: dateFormatter)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let notes = loan.notes, !notes.isEmpty {
                Text("Notas: \(notes)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .italic()
            }
        }
        .padding(.vertical, 4)
    }
}
