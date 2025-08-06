//
//  LendItemView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//

import SwiftUI

struct LendItemView: View {
    let item: Item
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State private var borrowerName = ""
    @State private var borrowerEmail = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                // Sección: Artículo a prestar
                Section {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Artículo:")
                            Spacer()
                            Text(item.name)
                                .fontWeight(.medium)
                        }
                        
                        HStack {
                            Text("Disponibles:")
                            Spacer()
                            Text("\(item.availableQuantity)")
                                .fontWeight(.medium)
                                .foregroundColor(.green) // Puedes poner color dinámico
                        }
                    }
                } header: {
                    Text("Artículo a Prestar")
                }
                
                // Sección: Información del solicitante
                Section {
                    VStack(spacing: 8) {
                        TextField("Nombre completo", text: $borrowerName)
                        TextField("Email", text: $borrowerEmail)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never) // Reemplazo de autocapitalization
                    }
                } header: {
                    Text("Información del Solicitante")
                }
                
                // Sección: Notas
                Section {
                    VStack {
                        TextEditor(text: $notes)
                            .frame(minHeight: 80)
                            .foregroundColor(.primary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondary.opacity(0.3))
                            )
                    }
                } header: {
                    Text("Notas (opcional)")
                }
            }
            .navigationTitle("Prestar Artículo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Prestar") {
                        if let itemId = item.id {
                            firebaseManager.lendItem(
                                itemId: itemId,
                                itemName: item.name,
                                borrowerName: borrowerName,
                                borrowerEmail: borrowerEmail,
                                notes: notes.isEmpty ? nil : notes
                            )
                        }
                        dismiss()
                    }
                    .disabled(borrowerName.isEmpty || borrowerEmail.isEmpty)
                }
            }
        }
    }
}
