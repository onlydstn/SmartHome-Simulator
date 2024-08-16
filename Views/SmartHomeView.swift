//
//  SmartHomeView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 12.08.24.
//

import SwiftUI

struct SmartHomeView: View {
    @State private var showingAlert: Bool = false
    @State private var inputText: String = ""
    @State private var displayedText: String = ""
    @State private var showRoomView: Bool = false
    @State private var selectedDeviceType: DeviceType = .light
    
    @State var smartHomeDevices: [SmartDevice] = [
        SmartDevice(name: "Wohnzimmerlicht", type: .light, isOn: false),
        SmartDevice(name: "Heizung", type: .thermostat, isOn: false, temperature: 15.0),
        SmartDevice(name: "Haustür", type: .lock, isOn: false, isLocked: false)
    ]
    
    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .trailing) {
                    TextField("gebe einen Text ein", text: $inputText)
                        .font(.system(size: 14))
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(5.0)
                    
                    Picker("Gerätetyp", selection: $selectedDeviceType) {
                        ForEach(DeviceType.allCases) { devicetype in
                            Label("\(devicetype.rawValue)", systemImage: devicetype.iconName).tag(devicetype)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.trailing, -5)
                }
                
                Button("hinzufügen") {
                    if inputText != "" {
                        addDevice()
                    } else {
                        showingAlert = true
                    }
                }
                .padding()
                .background(.gray.opacity((0.2)))
                .foregroundColor(.black)
                .cornerRadius(5.0)
                .font(.system(size: 14))
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Bitte triff eine Auswahl"),
                          message: Text("Bitte gebe einen Gerätename und einen Gerätetyp ein."))
                }
            }
            Divider()
                .padding(.bottom)
            
            HStack {
                Text("Geräte")
                    .font(.title3)
                    .padding(.vertical, -10)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            List {
                ForEach($smartHomeDevices) { devices in
                    SmartDeviceView(device: devices)
                        //.listRowBackground(Color(.clear))
                }
                .onDelete { indexSet in
                    smartHomeDevices.remove(atOffsets: indexSet)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, -20)
            .padding(.vertical, 16)
            
            HStack {
                if showRoomView {
                    RoomView(devices: smartHomeDevices)
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
        let newDevice: SmartDevice = SmartDevice(name: inputText, type: selectedDeviceType, isOn: false)
        smartHomeDevices.append(newDevice)
        inputText = ""
    }
}


#Preview {
    SmartHomeView()
}
