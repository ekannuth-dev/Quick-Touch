//
//  dataView.swift
//  QuickTouch
//
//  Created by Ehan kannuthurai on 2025-02-17.
//

import SwiftUI
import SwiftData

struct DataView: View {
   // @Environment(\.modelContext) private var modelContext
    @Query private var sessionData: [SessionData]
    
    // Computed properties to calculate statistics
    private var totalSessions: Int {
        sessionData.count
    }
    
    private var todaySessions: Int {
        sessionData.filter { Calendar.current.isDateInToday($0.date) }.count
    }
    
    private var monthSessions: Int {
        sessionData.filter { Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month) }.count
    }
    
    private var yearSessions: Int {
        sessionData.filter { Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .year) }.count
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Today's Sessions
                StatCard(
                    title: "Today's Sessions",
                    count: todaySessions,
                    iconName: "sun.max.fill",
                    color: .blue
                )
                
                // This Month's Sessions
                StatCard(
                    title: "This Month's Sessions",
                    count: monthSessions,
                    iconName: "calendar",
                    color: .orange
                )
                
                // This Year's Sessions
                StatCard(
                    title: "This Year's Sessions",
                    count: yearSessions,
                    iconName: "calendar.circle.fill",
                    color: .purple
                )
                
                // Total Sessions
                StatCard(
                    title: "Total Sessions",
                    count: totalSessions,
                    iconName: "star.fill",
                    color: .green
                )
            }
            .padding()
        }
        .navigationTitle("Statistics")
    }
}

struct StatCard: View {
    let title: String
    let count: Int
    let iconName: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(
                    color.opacity(0.2)
                )
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("\(count)")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

#Preview {
    NavigationStack {
        DataView()
    }
}






