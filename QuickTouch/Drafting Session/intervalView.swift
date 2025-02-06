//
//  intervalView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-05.
//

import SwiftUI

struct intervalView: View {
    @ObservedObject var draftModel: sessionViewModel
    
    @State private var availableColors: [(name: String, color: Color)] = [
        ("Red", .red),
        ("Blue", .blue),
        ("Green", .green),
        ("Yellow", .yellow),
        ("Orange", .orange),
        ("Purple", .purple)
    ]
    
    var body: some View {
        Section(header: Text("Select a Color").font(.headline)) {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 12) {
                ForEach(availableColors.indices, id: \.self) { index in
                    let colorItem = availableColors[index]
                    Circle()
                        .fill(colorItem.color)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text(colorItem.name)
                                .font(.caption)
                                .foregroundColor(.white)
                                .shadow(radius: 2)
                        )
                        .onTapGesture {
                            draftModel.intervalColor.append(colorItem.color) // ✅ Add color
                            availableColors.remove(at: index) // ✅ Remove from selection
                        }
                        .padding(5)
                }
            }
        }
        .padding()
        Section(header: Text("Selected Colors").font(.headline)) {
            if draftModel.intervalColor.isEmpty {
                Text("No colors selected")
                    .foregroundColor(.gray)
            } else {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 12) {
                    ForEach(draftModel.intervalColor.indices, id: \.self) { index in
                        let color = draftModel.intervalColor[index]
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding(10)
                            )
                            .onTapGesture {
                                availableColors.append(getColorInfo(for: color)) // ✅ Add back to selection
                                draftModel.intervalColor.remove(at: index) // ✅ Remove from selected
                            }
                            .padding(5)
                    }
                }
            }
        }
        
        Section {
            HStack {
                Text("Interval Seconds:")
                Spacer()
                Picker("Interval", selection: $draftModel.sessionInterval) {
                    ForEach(1...60, id: \.self) { num in
                        Text("\(num) sec")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 80)
            }
        }
        .padding()
    }
    
    func getColorInfo(for color: Color) -> (name: String, color: Color) {
        let allColors: [(name: String, color: Color)] = [
            ("Red", .red),
            ("Blue", .blue),
            ("Green", .green),
            ("Yellow", .yellow),
            ("Orange", .orange),
            ("Purple", .purple)
        ]
        return allColors.first { $0.color == color } ?? ("Unknown", color)
    }
}
