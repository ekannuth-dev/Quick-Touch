//
//  GameView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2024-09-06.
//

import Foundation
import SwiftUI
import StoreKit


struct settingView: View {
    @ObservedObject var draftModel : sessionViewModel
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section("Session") {
                        SettingSession(draftModel: draftModel)
                    }
                    Section("General"){
                        NavigationLink(destination: AboutView2()) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                Text("About Us")
                            }
                        }
                        NavigationLink(destination: AboutView2()) {
                            HStack {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.blue)
                                Text("How the App works")
                            }
                        }
                        Button(action: {
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: windowScene)
                            }
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.blue)
                                Text("Rate the App")
                            }
                        }
                    }
                    //                    if draftModel.isIntervalSession {
                    //                        intervalView(draftModel: draftModel)
                    //                    }
                    
                    //                    Section {
                    //                        HStack {
                    //                            Button("Start Session"){
                    //                                draftModel.draftAlert()
                    //                            }
                    //                            .padding()
                    //                            .background(Color.blue)
                    //                            .foregroundColor(.white)
                    //                            .clipShape(Capsule())
                    //                            .alert("Invalid Time", isPresented: $draftModel.timerAlert){
                    //                                Button("OK", role: .cancel){}
                    //                            } message: {
                    //                                Text("Please select a valid time greater than 0.")
                    //                            }
                    //                            .alert("Invalid Color Selection", isPresented: $draftModel.colorAlert){
                    //                                Button("OK", role: .cancel){}
                    //                            } message: {
                    //                                Text("Please select at least two colors")
                    //                            }
                    //                        }
                    //                        .frame(maxWidth: .infinity)
                    //                        .buttonStyle(PlainButtonStyle())
                    //                        .padding()
                    //                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}


#Preview {
    let mockModel = sessionViewModel() // Create a mock model with sample data
    settingView(draftModel: mockModel) // Pass the mock model to the view
}
