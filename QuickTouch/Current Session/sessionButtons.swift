//
//  buttonStack.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-10-21.
//

import Foundation
import SwiftUI


struct sessionButtons: View {
    @State var play: Bool //Bindings
    @State var reset: Bool //Bindings
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
                play.toggle()
            }
            label: {
                Image(systemName: "gobackward")
                    .resizable()               // Make the image resizable
                    .frame(width: 25, height: 25)
            }
        }
    }
}




#Preview {
    sessionButtons(play: false, reset: false)
}
