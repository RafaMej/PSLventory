//
//  ItemRowView.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI

struct ItemRowView: View {
    let item: Item
    @State private var showingLendSheet = false
    
    var availabilityColor: Color {
        if item.availableQuantity == 0 {
            return .red
        } else if item.availableQuantity <= item.totalQuantity / 3 {
            return .orange
        } else {
            return .green
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.category)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if !item.description.isEmpty {
                    Text(item.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(item.availableQuantity)/\(item.totalQuantity)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(availabilityColor)
                
                Text("disponibles")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if item.availableQuantity > 0 {
                    Button("Prestar") {
                        showingLendSheet = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                }
            }
        }
        .padding(.vertical, 4)
        .sheet(isPresented: $showingLendSheet) {
            LendItemView(item: item)
        }
    }
}
