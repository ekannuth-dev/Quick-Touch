//
//  intervalView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-05.
//

import SwiftUI

struct intervalView: View {
    @ObservedObject var draftModel: sessionViewModel

    var body: some View {
        Section(header: Text("Select a Color").font(.headline)) {
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 12) {
                ForEach(draftModel.availableColors.indices, id: \.self) { index in
                    let colorItem = draftModel.availableColors[index]
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
                            draftModel.availableColors.remove(at: index) // ✅ Remove from selection
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
                                draftModel.availableColors.append(getColorInfo(for: color))
                                draftModel.intervalColor.remove(at: index)
                            }
                            .padding(5)
                    }
                }
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
