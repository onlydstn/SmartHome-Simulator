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
        NavigationStack {
            VStack {
                HStack {
                    ZStack(alignment: .trailing) {
                        TextField("Gerätename", text: $inputText)
                            .font(.system(size: 14))
                            .padding(.horizontal, -10)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10.0)
                            .shadow(radius: 2)
                        
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
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                        } else {
                            showingAlert = true
                        }
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10.0)
                    .shadow(radius: 2)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Bitte triff eine Auswahl"),
                              message: Text("Bitte gebe einen Gerätename ein und wähle einen passenden Gerätetypen aus."))
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Geräte")
                        .font(.title3)
                        .padding(.vertical, -5)
                    Divider()
                        .padding(.top, 0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                List {
                    ForEach($smartHomeDevices) { devices in
                        SmartDeviceView(device: devices)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .padding(.vertical, 5)
                    }
                    .onDelete { indexSet in
                        smartHomeDevices.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, -20)
                
                HStack {
                    if showRoomView {
                        RoomView(devices: smartHomeDevices)
                            .cornerRadius(20)
                            .shadow(radius: 20)
                            .transition(.slide)
                            .padding()
                    }
                }
                //.padding(.top)
                .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.5), value: showRoomView)
            }
            .padding()
            .navigationTitle("Smart Home")
            
            Toggle(isOn: $showRoomView) {
                Text("Show RoomView")
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }
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
