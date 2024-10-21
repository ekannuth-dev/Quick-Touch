//
//  TimerView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-25.
//

import Foundation
import SwiftUI

struct TimerView: View {
    @Binding var sessionMin: Int
    @Binding var sessionSec: Int
    var body: some View {
        HStack{
            Picker("Select Timer", selection: $sessionMin){
                ForEach(0...59, id: \.self) {num in
                    Text("\(num)")
                }
            }.pickerStyle(.wheel)
                .padding()
            Text("Minutes")
            Picker("Intervals", selection: $sessionSec){
                ForEach(0...59, id: \.self) {num in
                    Text("\(num)")
                }
            }.pickerStyle(.wheel)
            Text("Seconds")
        }
    }
}
