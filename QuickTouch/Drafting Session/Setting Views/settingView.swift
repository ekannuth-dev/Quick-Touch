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
                        NavigationLink(destination: HowView()) {
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
                }
                .navigationTitle("Settings")
            }
        }
    }
}


#Preview {
    let mockModel = sessionViewModel()
    settingView(draftModel: mockModel)
}
