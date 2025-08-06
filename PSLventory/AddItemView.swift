//
//  AddItemView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    @State private var name = ""
    @State private var category = ""
    @State private var quantity = 1
    @State private var description = ""
    
    let categories = ["Electrónicos", "Herramientas", "Oficina", "Laboratorio", "Accesorios", "Otros"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del Artículo")) {
                    TextField("Nombre", text: $name)
                    
                    Picker("Categoría", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    
                    Stepper("Cantidad: \(quantity)", value: $quantity, in: 1...100)
                    
                    TextField("Descripción (opcional)", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Agregar Artículo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let newItem = Item(
                            name: name,
                            category: category,
                            totalQuantity: quantity,
                            description: description
                        )
                        firebaseManager.addItem(newItem)
                        dismiss()
                    }
                    .disabled(name.isEmpty || category.isEmpty)
                }
            }
        }
    }
}
