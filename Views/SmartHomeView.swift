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
            .padding(.bottom, 15)
            
            VStack(alignment: .leading) {
                ForEach(smartHomeDevices) { devices in
                    HStack(spacing: 68) {
                        Text(devices.name)
                        Spacer()
                        Text(devices.typeString)
                    }
                    Divider()
                }
            }
            .padding(.all, 10)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            HStack {
                if showRoomView {
                    RoomView()
                        .transition(.move(edge: .trailing))
                }
            }
            .padding(.top, 10)
            .animation(.easeInOut(duration: 0.15), value: showRoomView)
            Spacer()
        }
        .padding()
        Divider()
        
        Toggle(isOn: $showRoomView) {
            Text("Show RoomView")
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
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
