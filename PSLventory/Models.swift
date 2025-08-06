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
    var name: String
    var category: String
    var totalQuantity: Int
    var availableQuantity: Int
    var description: String
    var imageURL: String?
    var createdAt: Date
    
    init(name: String, category: String, totalQuantity: Int, description: String = "", imageURL: String? = nil) {
        self.name = name
        self.category = category
        self.totalQuantity = totalQuantity
        self.availableQuantity = totalQuantity
        self.description = description
        self.imageURL = imageURL
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
