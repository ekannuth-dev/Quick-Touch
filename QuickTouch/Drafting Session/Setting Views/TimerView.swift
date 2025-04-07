//
//  TimerView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-25.
//

import Foundation
import SwiftUI


struct TimerView: View {
    @ObservedObject var draftSession: sessionViewModel
    var body: some View {
        HStack(spacing: 10) { // ✅ Reduced spacing for compact look
            VStack {
                Picker("Minutes", selection: Binding(
                    get: { draftSession.initialMin },
                    set: { draftSession.initialMin = $0 }
                )) {
                    ForEach(0...59, id: \.self) { num in
                        Text("\(num)").font(.headline)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150) // ✅ Adjusted size
                Text("Min").font(.caption).foregroundColor(.gray) // ✅ Smaller text label
            }
            let _ = print(draftSession.initialMin)
            Text(":") // ✅ Adds a separator for clarity
                .font(.largeTitle)
                .fontWeight(.bold)
            
            VStack {
                Picker("Seconds", selection: Binding(
                    get: { draftSession.initialSec },
                    set: { draftSession.initialSec = $0 }
                )) {
                    ForEach(0...59, id: \.self) { num in
                        Text("\(num)").font(.headline)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                Text("Sec").font(.caption).foregroundColor(.gray) // ✅ Smaller text label
            }
        }
        .frame(maxWidth: 250) // ✅ Restrict max width for compactness
    }
}
