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
                Picker("Minutes", selection: $draftSession.initialMin) {
                    ForEach(0...59, id: \.self) { num in
                        Text("\(num)").font(.headline)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150) // ✅ Adjusted size
                Text("Min").font(.caption).foregroundColor(.gray) // ✅ Smaller text label
            }
            
            Text(":") // ✅ Adds a separator for clarity
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack {
                Picker("Seconds", selection: $draftSession.initialSec){
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
