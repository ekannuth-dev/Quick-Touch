//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI


struct draftView: View {
    @ObservedObject var draftModel : sessionViewModel
    @State private var timerAlert = false
    @State private var colorAlert = false
    @State private var isIntervalSession = false
    var body: some View {
        NavigationStack(){
            VStack {
                Form {
                    Section {
                        HStack {
                            TimerView(draftSession: draftModel)
                        }
                    }
                    Section {
                        Toggle("Enable Interval Session", isOn: $isIntervalSession)
                    }
                    
                    if isIntervalSession {
                        intervalView(draftModel: draftModel)
                    }
                    
                    Section {
                        HStack {
                            Button("Start Session"){
                                draftAlert()
                            }
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .alert("Invalid Time", isPresented: $timerAlert){
                                Button("OK", role: .cancel){}
                            } message: {
                                Text("Please select a valid time greater than 0.")
                            }
                            .alert("Invalid Color Selection", isPresented: $colorAlert){
                                Button("OK", role: .cancel){}
                            } message: {
                                Text("Please select at least two colors")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                    }
                }
            }
            .navigationTitle("Create Session")
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $draftModel.startSession){
                sessionView(sessionDraft: draftModel)
            }
        }
    }
    
    func draftAlert(){
        if draftModel.sessionMin == 0 && draftModel.sessionSec == 0 {
            timerAlert = true
        }
        else if isIntervalSession, draftModel.intervalColor.count < 2 {
            colorAlert = true
        }
        else {
            draftModel.startSession = true
        }
    }
}


#Preview {
    let mockModel = sessionViewModel() // Create a mock model with sample data
    draftView(draftModel: mockModel) // Pass the mock model to the view
}
