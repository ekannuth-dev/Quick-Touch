//
//  intervalView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-05.
//

import SwiftUI

struct intervalView: View {
    @ObservedObject var draftModel: sessionViewModel
    
    // Constants for better maintainability
    private let circleSize: CGFloat = 40
    private let gridSpacing: CGFloat = 8
    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 4)

    var body: some View {
        VStack(spacing: 10) {
            // Available Colors Section
            VStack(alignment: .leading, spacing: 5) {
                Text("Select up to 5 Colors")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding()
                
                LazyVGrid(columns: gridColumns, spacing: gridSpacing) {
                    ForEach(draftModel.availableColors.indices, id: \.self) { index in
                        let colorItem = draftModel.availableColors[index]
                        colorCircle(
                            color: colorItem.color,
                            label: colorItem.name,
                            action: {
                                draftModel.intervalColor.append(colorItem.color)
                                draftModel.availableColors.remove(at: index)
                            }
                        )
                    }
                }
            }
            
            // Selected Colors Section
            VStack(alignment: .leading, spacing: 5) {
                Text("Selected Colors")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                if draftModel.intervalColor.isEmpty {
                    Text("No colors selected")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    LazyVGrid(columns: gridColumns, spacing: gridSpacing) {
                        ForEach(draftModel.intervalColor.indices, id: \.self) { index in
                            let color = draftModel.intervalColor[index]
                            colorCircle(
                                color: color,
                                isSelected: true,
                                action: {
                                    draftModel.availableColors.append(getColorInfo(for: color))
                                    draftModel.intervalColor.remove(at: index)
                                }
                            )
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // Extracted color circle view for reusability
    private func colorCircle(color: Color, label: String? = nil, isSelected: Bool = false, action: @escaping () -> Void) -> some View {
        Circle()
            .fill(color)
            .frame(width: circleSize, height: circleSize)
            .overlay(
                Group {
                    if isSelected {
                        Image(systemName: "xmark")
                            .font(.caption)
                            .foregroundColor(.white)
                    } else if let label = label {
                        Text(label)
                            .font(.caption2)
                            .foregroundColor(.white)
                            .shadow(radius: 1)
                    }
                }
            )
            .onTapGesture(perform: action)
    }
    
    // Existing getColorInfo function
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
