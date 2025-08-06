//
//  ReturnedLoanRowView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI

struct ReturnedLoanRowView: View {
    let loan: Loan
    
    var loanDuration: Int {
        guard let returnDate = loan.returnDate else { return 0 }
        return Calendar.current.dateComponents([.day], from: loan.loanDate, to: returnDate).day ?? 0
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
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    
                    Text("\(loanDuration) días")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Text("Prestado: \(loan.loanDate, formatter: dateFormatter)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if let returnDate = loan.returnDate {
                    Text("Devuelto: \(returnDate, formatter: dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
