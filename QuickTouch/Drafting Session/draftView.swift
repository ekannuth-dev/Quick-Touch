//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct draftView: View {
    @StateObject var draftView = sessionViewModel()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack{
                        TimerView(sessionMin: $draftView.sessionMin, sessionSec: $draftView.sessionSec)
                    }
                }
                Section{
                    HStack{
                        Text("Interval Seconds:")
                        TextField("Enter Seconds", value: $draftView.sessionInterval, formatter: NumberFormatter())
                            .frame(height: 50)
                    }
                }
                Section {
                    HStack{
                        Button(action: {
                            draftView.onValid = true
                        }) {
                            Text("Start Session")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
            }
            .navigationDestination(isPresented: $draftView.onValid){
                sessionView(sessionDraft: draftView)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Create Session")
        }
    }
}


#Preview {
    draftView()
}
