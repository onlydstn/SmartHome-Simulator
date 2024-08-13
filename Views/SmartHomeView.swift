//
//  SmartHomeView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 12.08.24.
//

import SwiftUI

struct SmartHomeView: View {
    @State private var inputText: String = ""
    @State var displayedText: String = ""
    @State var showRoomView: Bool = false
    
    @State var smartHomeDevices: [SmartDevice] = [
        SmartDevice(name: "Wohnzimmerlicht", type: .light, isOn: false),
        SmartDevice(name: "Heizung", type: .thermostat, isOn: false, temperature: 20.0),
        SmartDevice(name: "Haustür", type: .lock, isOn: false, isLocked: false)
    ]
    
    var body: some View {
        VStack {
            HStack {
                TextField("gebe einen Text ein", text: $inputText)
                    .font(.system(size: 16))
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                
                Button("hinzufügen") {
                    addDevice()
                }
                .padding()
                .background(.gray.opacity((0.2)))
                .foregroundColor(.black)
                .cornerRadius(5.0)
            }
            .padding()
            
            ForEach(smartHomeDevices) { devices in
                    HStack {
                        Text(devices.name)
                        Spacer()
                        Text(devices.typeString)
                    }
                    .background(.red)
                }
            
            ZStack {
                if showRoomView {
                    RoomView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut(duration: 0.3), value: showRoomView)
            Spacer()
            
        }
        .padding()
        
        Divider()
        Toggle(isOn: $showRoomView) {
            Text("Show RoomView")
        }
        .padding()
        
    }
    
    private func addDevice() {
        let newDevice: SmartDevice = SmartDevice(name: inputText, type: .none, isOn: false)
        smartHomeDevices.append(newDevice)
        inputText = ""
    }

}


#Preview {
    SmartHomeView()
}
