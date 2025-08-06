//
//  MainApp.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import SwiftUI
import FirebaseCore
import Firebase
import FirebaseFirestore

@main
struct LendingSystemApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
