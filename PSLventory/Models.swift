//
//  Models.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//

import SwiftUI
import FirebaseFirestore

struct Item: Identifiable, Codable {
    @DocumentID var id: String?
    var availableQuantity: Int
    var category: String
    var name: String
    var number: Int
    var project: String
    var qr: String
    var description: String
    var subcategories: String
    var totalQuantity: Int
    var createdAt: Date
        
        init(category: String,
             name: String,
             number: Int,
             project: String,
             qr: String,
             subcategories: String,
             totalQuantity: Int,
             description: String = "") {
            
            
            self.category = category
            self.name = name
            self.number = number
            self.project = project
            self.qr = qr
            self.subcategories = subcategories
            self.availableQuantity = totalQuantity
            self.totalQuantity = totalQuantity
            self.description = description
            self.createdAt = Date()
        }
}

struct Loan: Identifiable, Codable {
    @DocumentID var id: String?
    var itemId: String
    var itemName: String
    var borrowerName: String
    var borrowerEmail: String
    var loanDate: Date
    var returnDate: Date?
    var isActive: Bool
    var notes: String?
    
    init(itemId: String, itemName: String, borrowerName: String, borrowerEmail: String, notes: String? = nil) {
        self.itemId = itemId
        self.itemName = itemName
        self.borrowerName = borrowerName
        self.borrowerEmail = borrowerEmail
        self.loanDate = Date()
        self.returnDate = nil
        self.isActive = true
        self.notes = notes
    }
}
