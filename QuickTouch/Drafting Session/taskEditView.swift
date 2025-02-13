//
//  taskEditor.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-06.
//

import SwiftUI

struct Goal: Hashable, Identifiable {
    var name: String
    var id: String { name }
}

struct Task {
    var name: String
    var servingGoals: Set<Goal>
}

let allGoals: [Goal] = [
    Goal(name: "Learn Japanese"),
    Goal(name: "Learn SwiftUI"),
    Goal(name: "Learn Serverless with Swift")
]

import SwiftUI

struct taskEditView: View {
    @ObservedObject var draftModel: sessionViewModel
    @State private var selectedColor: Color = .blue // ✅ Temporary selection before adding

    var body: some View {
        Section {
            HStack {
                Text("Select Color:")
                ColorPicker("", selection: $selectedColor) // ✅ Select a color
                    .frame(width: 50, height: 30)
                
                Button("Add") { // ✅ Add selected color to array
                    draftModel.intervalColor.append(selectedColor)
                }
                .padding(.horizontal)
            }
        }
        
        Section(header: Text("Selected Colors")) {
            if draftModel.intervalColor.isEmpty {
                Text("No colors selected")
                    .foregroundColor(.gray)
            } else {
                ForEach(draftModel.intervalColor.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(draftModel.intervalColor[index])
                            .frame(width: 30, height: 30)
                        Spacer()
                        Button("Remove") {
                            draftModel.intervalColor.remove(at: index) // ✅ Remove color
                        }
                        .foregroundColor(.red)
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
    }
}
