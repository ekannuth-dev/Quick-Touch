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
        HStack {
            Picker("Select Timer", selection: $draftSession.initialMin){
                ForEach(0...59, id: \.self) {num in
                    Text("\(num)")
                }
            }.pickerStyle(.wheel)
                .padding()
            Text("Minutes")
            Picker("Intervals", selection: $draftSession.initialSec){
                ForEach(0...59, id: \.self) {num in
                    Text("\(num)")
                }
            }.pickerStyle(.wheel)
            Text("Seconds")
        }
//        .onChange(of: draftSession.initialMin) {
//            draftSession.saveTime() }
//        .onChange(of: draftSession.initialSec){
//            draftSession.saveTime() }
    }
}
