//
//  ContentView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    @StateObject private var firebaseManager = FirebaseManager()
    
    var body: some View {
        TabView {
            InventoryView()
                .tabItem {
                    Image(systemName: "cube.box")
                    Text("Inventario")
                }
            
            LoansView()
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Préstamos")
                }
            /*
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Estadísticas")
                }
            */
        }
        .environmentObject(firebaseManager)
        .accentColor(.blue)
    }
}
