//
//  RoomView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 12.08.24.
//

import SwiftUI

struct RoomView: View {
    
    var body: some View {
            VStack {
                Spacer()
                Rectangle()
                    .frame(maxWidth: 360, maxHeight: 520)
                    .cornerRadius(15)
                    .foregroundStyle(Color(.gray).opacity(0.2))
            }
        }
    }
