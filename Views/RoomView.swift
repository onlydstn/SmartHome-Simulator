//
//  RoomView.swift
//  SmartHome
//
//  Created by Dustin Nuzzo on 12.08.24.
//

import SwiftUI

struct RoomView: View {
    var devices: [SmartDevice]

    var body: some View {
        ZStack {
            // Background wall
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray5))
                .frame(height: 200)
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            // Left wall
                            Path { path in
                                path.move(to: CGPoint(x: 10, y: 40))
                                path.addLine(to: CGPoint(x: 60, y: 0))
                                path.addLine(to: CGPoint(x: 60, y: 150))
                                path.addLine(to: CGPoint(x: 10, y: 190))
                                path.closeSubpath()
                            }
                            .fill(Color(UIColor.systemGray4))
                        }
                    }
                )
                .padding([.leading, .trailing], 25)
            
            // Floor
            Path { path in
                path.move(to: CGPoint(x: 100, y: 170))
                path.addLine(to: CGPoint(x: 300, y: 170))
                path.addLine(to: CGPoint(x: 280, y: 210))
                path.addLine(to: CGPoint(x: 50, y: 212))
                path.closeSubpath()
            }
            .fill(Color(UIColor.systemGray4))
            // Carpet
            Path { path in
                path.move(to: CGPoint(x: 160, y: 170))
                path.addLine(to: CGPoint(x: 270, y: 170))
                path.addLine(to: CGPoint(x: 255, y: 195))
                path.addLine(to: CGPoint(x: 145, y: 195))
                path.closeSubpath()
            }
            .fill(Color.red)
            
            // Light
            if let light = devices.first(where: { $0.type == .light }) {
                LightView(isOn: light.isOn)
                    .frame(width: 50, height: 50)
                    .offset(x: -50, y: -50)
            }
            // Thermostat
            if let thermostat = devices.first(where: { $0.type == .thermostat }) {
                Text("\(Int(thermostat.temperature))°C")
                    .foregroundColor(thermostat.temperature > 22 ? .red : .blue)
                    .font(.largeTitle)
                    .offset(x: 100, y: -80)
            }
            // Door
            if let lock = devices.first(where: { $0.type == .lock }) {
                LockView(isLocked: lock.isLocked)
                    .frame(width: 60, height: 100)
                    .offset(x: 100, y: 50)
            }
        }
        .frame(width:350, height: 220)
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct LightView: View {
    var isOn: Bool

    var body: some View {
        ZStack {
            LampShape()
                .stroke(Color.black, lineWidth: 2)
                .background(LampShape().fill(isOn ? Color.yellow : Color.gray))
                .shadow(radius: isOn ? 10 : 0)
            if isOn {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
            }
        }
    }
}

struct LampShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + 90))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY + 90))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY + 90))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + 90))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY + 90))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + 90))
        path.addLine(to: CGPoint(x: rect.midX - 10, y: rect.maxY + 90))
        path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY + 90))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + 90))
        return path
    }
}

struct LockView: View {
    var isLocked: Bool

    var body: some View {
        ZStack {
            DoorShape()
                .stroke(Color.black, lineWidth: 2)
                .background(DoorShape().fill(Color.brown))
            Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                .foregroundColor(.black)
                .font(.largeTitle)
                .offset(x: -50, y: -40)
        }
    }
}

struct DoorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX - 50, y: rect.minY - 40))
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: rect.minY - 40))
        path.addLine(to: CGPoint(x: rect.maxX - 50, y: rect.maxY - 40))
        path.addLine(to: CGPoint(x: rect.minX - 50, y: rect.maxY - 40))
        path.addLine(to: CGPoint(x: rect.minX - 50, y: rect.minY - 40))
        path.move(to: CGPoint(x: rect.midX - 50, y: rect.maxY - 40))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.minY - 40))
        return path
    }
}

#Preview {
    RoomView(devices: [])
}
