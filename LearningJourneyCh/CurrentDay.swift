//
//  CurrentDay.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct CurrentDay: View {
    @State private var selectedDay: String = ""
    @State private var streakCount: Int = 10
    @State private var freezeCount: Int = 2
    @State private var currentDate: Date = Date() // The current date
    @State private var learningGoal: String = "Swift"
    
    // Computed properties for current month and year
    private var currentMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM" // Full month name (e.g., "September")
        return dateFormatter.string(from: currentDate)
    }
    
    private var currentYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" // Year (e.g., "2024")
        return dateFormatter.string(from: currentDate)
    }
    
    // Get the day of the current date
    private var currentDay: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: currentDate)
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text(selectedDay)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Learning \(learningGoal)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        // NavigationLink for the flame image
                        NavigationLink(destination: updateLearningGoal()) {
                            Image("flame")
                                .resizable()
                                .frame(width: 30, height: 40)
                                .background(
                                    Color("Gray5")
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                )
                                .padding()
                        }
                    }
                    .padding()
                    
                    
                    // Calendar Section
                    VStack {
                        // Calendar
                        HStack {
                            Text("\(currentMonth) \(currentYear)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                            HStack(spacing: 10) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.orange)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.horizontal)
                        
                        
                        // Days of the Week Header
                        HStack {
                            ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                                Text(day)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            ForEach(1..<8) { day in
                                DayCircle(day: day, selectedDay: $selectedDay, currentDay: currentDay)
                            }
                        }
                        Divider()
                            .overlay(Color.gray)
                            .padding(.horizontal)
                        
                        
                        // Streak & Freeze Count
                        HStack {
                            VStack {
                                Text("\(streakCount) 🔥")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("Day streak")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                            Divider()
                                .overlay(.gray)
                            
                            VStack {
                                Text("\(freezeCount)🧊")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("Day freezed")
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding([.leading, .bottom, .trailing])
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1)
                            .background(Color("darkBackground"))
                    )
                    .padding(.horizontal)
                    
                    // Log Button
                    Button(action: {
                        // Action for log button
                    }) {
                        Text("Log today\nas Learned")
                            .font(.title)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(width: 250, height: 250)
                            .background(Circle().fill(Color.orange))
                    }
                    .padding()
                    
                    // Freeze Button
                    VStack {
                        Button(action: {
                            // Action for freeze button
                        }) {
                            Text("Freeze day")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(width: 200)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color("light blue"))
                                )
                        }
                        Text("2 out of 6 freezes used")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            } //ZStack
        }
        .onAppear {
            // Set the current date as the default day
            selectedDay = getCurrentDateString()
        }
    }
    
    
    // Helper function to get the current date in the desired format
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM"  // Format like "Wednesday, 11 SEP"
        return dateFormatter.string(from: Date())
    }
}
struct DayCircle: View {
    let day: Int
    @Binding var selectedDay: String
    let currentDay: Int
    
    var body: some View {
        VStack {
            Text("\(day)")
                .font(.headline)
                .foregroundColor(day == currentDay ? .blue : .gray)
                .padding(10)
                .background(
                    Circle()
                        .fill(day == currentDay ? Color.orange.opacity(0.7) : Color.clear)
                )
                .onTapGesture {
                    selectedDay = "Day \(day)" // Update selected day based on the tapped day
                }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CurrentDay()
}

