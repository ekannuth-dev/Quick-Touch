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
                    .foregroundColor(.red)
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
                    .foregroundColor(.red)
            }
            .padding()
            .alert("Do you want to restart the session?", isPresented: $alertReset, actions: {
                  Button("No", role: .cancel, action: {
                      sameSession.play = true
                  })
                  Button("Yes", role: .destructive, action: {
                      sameSession.resetSession()
                  })
                })
            Button {
                sameSession.play = false
                alertCancel.toggle()
            }
            label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(.red)
            }
            .alert("Are you sure you want to cancel the session?", isPresented: $alertCancel, actions: {
                Button("Yes", role: .destructive, action: {
                    sameSession.makeSession()
                })
                Button("No", role: .cancel, action: {
                    sameSession.play = true
                })
            })
        }
    }
}




