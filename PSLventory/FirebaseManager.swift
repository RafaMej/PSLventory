//
//  FirebaseManager.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

class FirebaseManager: ObservableObject {
    @Published var items: [Item] = []
    @Published var loans: [Loan] = []
    @Published var isLoading = false
    
    private let db = Firestore.firestore()
    
    init() {
        fetchItems()
        fetchLoans()
    }
    
    func fetchItems() {
        isLoading = true
        db.collection("OFFICE").addSnapshotListener { snapshot, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let documents = snapshot?.documents {
                    self.items = documents.compactMap { doc in
                        try? doc.data(as: Item.self)
                    }
                }
            }
        }
    }
    
    func fetchLoans() {
        db.collection("loans").addSnapshotListener { snapshot, error in
            DispatchQueue.main.async {
                if let documents = snapshot?.documents {
                    self.loans = documents.compactMap { doc in
                        try? doc.data(as: Loan.self)
                    }
                }
            }
        }
    }
    
    func addItem(_ item: Item) {
        do {
            try db.collection("OFFICE").addDocument(from: item)
        } catch {
            print("Error adding item: \(error)")
        }
    }
    
    func lendItem(itemId: String, itemName: String, borrowerName: String, borrowerEmail: String, notes: String?) {
        let loan = Loan(itemId: itemId, itemName: itemName, borrowerName: borrowerName, borrowerEmail: borrowerEmail, notes: notes)
        
        do {
            try db.collection("loans").addDocument(from: loan)
            
            // Update item availability
            if let itemIndex = items.firstIndex(where: { $0.id == itemId }) {
                var updatedItem = items[itemIndex]
                updatedItem.availableQuantity -= 1
                
                if let id = updatedItem.id {
                    try db.collection("OFFICE").document(id).setData(from: updatedItem)
                }
            }
        } catch {
            print("Error lending item: \(error)")
        }
    }
    
    func returnItem(loanId: String) {
        guard let loanIndex = loans.firstIndex(where: { $0.id == loanId }) else { return }
        
        var updatedLoan = loans[loanIndex]
        updatedLoan.isActive = false
        updatedLoan.returnDate = Date()
        
        do {
            if let id = updatedLoan.id {
                try db.collection("loans").document(id).setData(from: updatedLoan)
            }
            
            // Update item availability
            if let itemIndex = items.firstIndex(where: { $0.id == updatedLoan.itemId }) {
                var updatedItem = items[itemIndex]
                updatedItem.availableQuantity += 1
                
                if let itemId = updatedItem.id {
                    try db.collection("OFFICE").document(itemId).setData(from: updatedItem)
                }
            }
        } catch {
            print("Error returning item: \(error)")
        }
    }
}
