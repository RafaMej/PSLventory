import SwiftUI

struct StatsView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var totalItems: Int {
        firebaseManager.items.reduce(0) { $0 + $1.totalQuantity }
    }
    
    var availableItems: Int {
        firebaseManager.items.reduce(0) { $0 + $1.availableQuantity }
    }
    
    var lentItems: Int {
        totalItems - availableItems
    }
    
    var activeLoans: Int {
        firebaseManager.loans.filter { $0.isActive }.count
    }
    
    var totalLoans: Int {
        firebaseManager.loans.count
    }
    
    var categoryStats: [String: Int] {
        Dictionary(grouping: firebaseManager.items, by: { $0.category })
            .mapValues { $0.reduce(0) { $0 + $1.totalQuantity } }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Resumen General")) {
                    StatsRowView(title: "Total de Artículos", value: "\(totalItems)", color: .blue)
                    StatsRowView(title: "Disponibles", value: "\(availableItems)", color: .green)
                    StatsRowView(title: "Prestados", value: "\(lentItems)", color: .orange)
                    StatsRowView(title: "Préstamos Activos", value: "\(activeLoans)", color: .red)
                    StatsRowView(title: "Total de Préstamos", value: "\(totalLoans)", color: .purple)
                }
                
                Section(header: Text("Por Categoría")) {
                    ForEach(categoryStats.sorted(by: { $0.value > $1.value }), id: \.key) { category, count in
                        HStack {
                            Text(category)
                            Spacer()
                            Text("\(count)")
                                .fontWeight(.medium)
                        }
                    }
                }
                
                Section(header: Text("Utilización")) {
                    let utilizationRate = totalItems > 0 ? Double(lentItems) / Double(totalItems) * 100 : 0
                    
                    HStack {
                        Text("Tasa de Utilización")
                        Spacer()
                        Text("\(utilizationRate, specifier: "%.1f")%")
                            .fontWeight(.medium)
                            .foregroundColor(utilizationRate > 50 ? .green : .orange)
                    }
                }
            }
            .navigationTitle("Estadísticas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
