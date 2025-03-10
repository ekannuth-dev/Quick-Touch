//
//  buttonStack.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-10-21.
//

import Foundation
import SwiftUI


struct sessionButtons: View {
    @ObservedObject var sameSession: sessionViewModel
    @State var alertReset : Bool = false
    @State var alertCancel : Bool = false
    var body: some View {
        HStack {
            Button {
                sameSession.play.toggle()
            }
            label: {
                Image(systemName:  sameSession.play ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.blue)
            }
            .padding()
            Button {
                alertReset.toggle()
                sameSession.play = false
            }
            label: {
                Image(systemName: "gobackward")
                    .resizable()               // Make the image resizable
                    .frame(width: 25, height: 25)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.blue)
            }
            .padding()
            .alert("Do you want to restart the session?", isPresented: $alertReset, actions: {
                Button("Continue", role: .cancel) {
                    sameSession.play = true
                }
                Button("Restart", role: .destructive){
                    sameSession.resetSession()
                }
            })
        }
    }
}




