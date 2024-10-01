//
//  circularProgressView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-30.
//

import Foundation
import SwiftUI

struct CircularProgressView: View {
    var progress: Float = 10.0
    var body: some View {
        ZStack {
            // Gray circle
            Circle()
                .stroke(lineWidth: 8.0)
                .opacity(0.3)
                .foregroundColor(Color("TimerButtonCancel"))
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 8.0,
                    lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("TimerButtonPause"))
                // Ensures the animation starts from 12 o'clock
                .rotationEffect(Angle(degrees: 270))
        }
        .animation(.linear(duration: 1.0), value: progress)
    }
}


#Preview {
    CircularProgressView(progress: 2)
}
