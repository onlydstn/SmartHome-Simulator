//
//  SmartDeviceView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 15.08.24.
//

import SwiftUI

struct SmartDeviceView: View {
    @Binding var device: SmartDevice
    @State private var value: Double = 7.0
    
    var body: some View {
        HStack(alignment: .center) {
            switch device.type {
                
            case .light:
                Image(systemName: "chandelier")
                VStack(alignment: .leading) {
                    Text(device.name)
                    Text("\(device.typeString)")
                        .font(.footnote)
                }
                Toggle(isOn: $device.isOn) {
                    Text("")
                }
                
            case .thermostat:
                Image(systemName: "heater.vertical")
                VStack(alignment: .leading) {
                    Text(device.name)
                    Text("\(device.typeString)")
                        .font(.footnote)
                }
                Slider(value: $device.temperature, in: 7...28)
                Text(String(format: "%.2f", device.temperature))
                
            case .lock:
                if device.isLocked {
                    Image(systemName: "door.right.hand.closed")
                    VStack(alignment: .leading) {
                        Text(device.name)
                        Text("\(device.typeString)")
                            .font(.footnote)
                    }
                    Button {
                        device.isLocked = false
                    } label: {
                        Image(systemName: "lock")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.title)
                    
                } else {
                    Image(systemName: "door.right.hand.open")
                    VStack(alignment: .leading) {
                        Text(device.name)
                        Text("\(device.typeString)")
                            .font(.footnote)
                    }
                    Button {
                        device.isLocked = true
                    } label: {
                        Image(systemName: "lock.open")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.title)
                }
                
            default:
                Image(systemName: "exclamationmark.triangle")
            }
        }
    }
}

#Preview {
    SmartDeviceView(device:.constant(
        SmartDevice(name: "Wohnzimmerlicht", type: .light, isOn: false)))
}
