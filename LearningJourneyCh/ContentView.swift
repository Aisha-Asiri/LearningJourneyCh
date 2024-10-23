//
//  ContentView.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasStarted") var hasStarted: Bool = false // Store user progress
    @State private var learningGoal: String = "Swift"
    @State private var selectedTimeFrame: String = "Month"
    
    var body: some View {
        if hasStarted {
            // If user has already started, go to CurrentDayView directly
            CurrentDay()
        } else {
            // Main Page Content
            NavigationStack {
                VStack(spacing: 50) {
                    // Flame Icon
                    Image("flame")
                        .resizable()
                        .frame(width: 40, height: 50)
                        .background(
                            Color("light black")
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        )
                    VStack {
                        Text ("Hello Learner!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        Text ("This app will help you learn everyday")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    // Input for Learning Goal
                    VStack {
                        Text ("I want to learn")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        ZStack(alignment: .bottom) {
                            
                            TextField("Swift", text: $learningGoal)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                                .accentColor(.orange)
                            // Bottom line (underline)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                        } //ZStach
                        .padding(.horizontal)
                        
                        // Timeframe selection
                        VStack(alignment: .leading) {
                            Text("I want to learn it in a")
                                .font(.headline)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .leading])
                            
                            
                            HStack(spacing: 20) {
                                Button(action: {
                                    selectedTimeFrame = "Week"
                                }) {
                                    Text("Week")
                                        .foregroundColor(selectedTimeFrame == "Week" ? .black : .orange)
                                        .padding()
                                        .background(selectedTimeFrame == "Week" ? Color.orange : Color("light black"))
                                        .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    selectedTimeFrame = "Month"
                                }) {
                                    Text("Month")
                                        .foregroundColor(selectedTimeFrame == "Month" ? .black : .orange)
                                        .padding()
                                        .background(selectedTimeFrame == "Month" ? Color.orange : Color("light black"))
                                        .cornerRadius(10)
                                }
                                
                                Button(action: {
                                    selectedTimeFrame = "Year"
                                }) {
                                    Text("Year")
                                        .foregroundColor(selectedTimeFrame == "Year" ? .black : .orange)
                                        .padding()
                                        .background(selectedTimeFrame == "Year" ? Color.orange : Color("light black"))
                                        .cornerRadius(10)
                                }
                            }
                        } //HStack
                    }
                        // Navigation to CurrentDayView
                        NavigationLink(destination: CurrentDay()) {
                            Button(action: {
                                hasStarted.toggle()                            }) {
                                    Text("Start →")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(width: 200, height: 50)
                                        .background(Color.orange)
                                        .cornerRadius(10)
                                }
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            // Set the flag to true so the main page doesn't appear again
                            hasStarted = true
                        })
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.black.edgesIgnoringSafeArea(.all))
                }
            }
        }
    }
    
    // Custom Button for Timeframe Selection
    struct TimeframeButton: View {
        let title: String
        let isSelected: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .foregroundColor(isSelected ? .black : .white)
                    .padding()
                    .background(isSelected ? Color.orange : Color(.systemGray6))
                    .cornerRadius(10)
            }
        }
    }



#Preview {
    ContentView()
}
