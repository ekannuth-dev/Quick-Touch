//
//  buttonStack.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-10-21.
//

import Foundation
import SwiftUI


struct sessionButtons: View {
    @Binding var play: Bool //Bindings
    @Binding var reset: Bool //Bindings
    var body: some View {
        HStack {
            Button {
                play.toggle()
            }
            label: {
                Image(systemName:  play ? "pause.fill" : "play.fill")
                    .resizable()               // Make the image resizable
                    .frame(width: 25, height: 25)
            }
            .padding()
            Button {
                reset.toggle()
            }
            label: {
                Image(systemName: "gobackward")
                    .resizable()               // Make the image resizable
                    .frame(width: 25, height: 25)
                    .font(.system(size: 25, weight: .bold))
            }
            .padding()
            Button {
                reset.toggle()
            }
            label: {
                Image(systemName: "xmark")
                    .resizable()               // Make the image resizable
                    .frame(width: 25, height: 25)
                    .font(.system(size: 25, weight: .bold))
            }
        }
    }
}




