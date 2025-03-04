//
//  TestView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-03-04.
//



import SwiftUI

struct HowView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // ✅ Title
                Text("About the App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                // ✅ Description
                Text("This app is designed for athletes looking to enhance their reaction time, precision, and focus. Whether you are training for speed, agility, or timed sessions, this app helps you track and improve your performance with structured timing and session management features.")
                    .font(.body)
                    .multilineTextAlignment(.leading)

                // ✅ Features Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Key Features:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 10)

                    FeatureRow(icon: "stopwatch.fill", text: "Timed sessions to measure reaction speed.")
                    FeatureRow(icon: "chart.bar.fill", text: "Track your progress over time.")
                    FeatureRow(icon: "figure.run", text: "Customizable training modes for different sports.")
                    FeatureRow(icon: "bell.fill", text: "Notifications to keep you on track with your sessions.")
                }

                // ✅ Call to Action
                Text("Train smarter, react faster, and take your athletic performance to the next level!")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top, 15)
            }
            .padding()
        }
    }
}

// ✅ Feature Row Component
struct FeatureRow: View {
    var icon: String
    var text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.title2)
            Text(text)
                .font(.body)
        }
    }
}


#Preview {
    HowView()
}
