//
//  InventoryView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore

struct InventoryView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    @State private var showingAddItem = false
    @State private var searchText = ""
    
    var filteredItems: [Item] {
        if searchText.isEmpty {
            return firebaseManager.items
        } else {
            return firebaseManager.items.filter { item in
                item.name.localizedCaseInsensitiveContains(searchText) ||
                item.category.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                
                if firebaseManager.isLoading {
                    ProgressView("Cargando inventario...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(filteredItems) { item in
                        ItemRowView(item: item)
                    }
                }
            }
            .navigationTitle("Inventario")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddItem = true }) {
                        Image(systemName: "plus")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView()
            }
        }
    }
}

