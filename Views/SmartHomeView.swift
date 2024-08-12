//
//  SmartHomeView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 12.08.24.
//

import SwiftUI

struct SmartHomeView: View {
    @State var inputText: String = ""
    @State var displayedText: String = ""
    @State var showRoomView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("gebe einen Text ein", text: $inputText)
                    .font(.system(size: 16))
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(5.0)
                
                Button("hinzufügen") {
                    displayedText = inputText
                }
                .padding()
                .background(.gray.opacity((0.2)))
                .foregroundColor(.black)
                .cornerRadius(5.0)
            }
            .padding()
            
            Text(displayedText)
                .font(.system(size: 22))
            
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
}

#Preview {
    SmartHomeView()
}
