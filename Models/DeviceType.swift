//
//  DeviceType.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 13.08.24.
//

import Foundation

enum DeviceType: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .light:
            return "lightbulb.max"
        case .thermostat:
            return "thermometer.high"
        case .lock:
            return "lock"
        }
    }
    
    case light = "Licht"
    case thermostat = "Heizung"
    case lock = "Schloss"
}

struct SmartDevice: Identifiable {
    let id: UUID = UUID()
    
    var name: String
    var type: DeviceType? = nil // optional damit case .none nutzbar ist
    var isOn: Bool
    var temperature: Double = 20.0
    var isLocked: Bool = true
    
    // Computed Property um DeviceType als String in einer View anzeigen zu lassen
    var typeString: String {
        switch type {
        case .light:
            return "Licht"
        case .thermostat:
            return "Heizung"
        case .lock:
            return "Schloss"
        case .none:
            return "kein Type" // wenn neues Objekt aus
        }
    }
}

