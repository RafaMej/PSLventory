//
//  dateFormatter.swift
//  PSLventory
//
//  Created by Rafael Mejía López on 04/08/25.
//
import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
