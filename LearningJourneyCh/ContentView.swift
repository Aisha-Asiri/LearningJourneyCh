
//
//  ContentView.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var learningGoal: String = ""
    @FocusState private var focus: Bool

    @AppStorage("selectedTimeFrame") var selectedTimeFrame: String = "Month"

    @AppStorage("isStart") var isStart: Bool = true
    
    
    var body: some View {
        NavigationView {
                ZStack {
                    Color(.black)
                        .ignoresSafeArea(.all)
                    VStack(spacing: 50) {
                        // Flame Icon
                        Text ("🔥")
                            .fontWeight(.regular)
                            .frame(width: 150, height: 100)
                            .font(.system(size: 52))
                            .background(
                                Color("Gray5")
                                    .frame(width: 118, height: 118)
                                    .clipShape(Ellipse())
                            )
                        VStack {
                            Text ("Hello Learner!")
                                .font(.system(size:32, weight: .bold))
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding([.top, .leading])
                            Text ("This app will help you learn everyday")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.gray3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                        // Input for Learning Goal
                        VStack {
                            Text ("I want to learn")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                            
                            ZStack(alignment: .bottom) {
                                TextField("Swift", text: $learningGoal)
                                    .foregroundColor(
                                        Color("Gray3")
                                    )
                                    .font(.system(size: 17, weight: .regular))
                                    .padding(.bottom, 5)
                                    .focused($focus)
                                    .accentColor(.orange)
                                    .onAppear() {focus = true}
                                // Bottom line (underline)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("Gray3"))
                            } //ZStach
                            .padding(.horizontal)
                            
                            // Timeframe selection
                            VStack(alignment: .leading) {
                                Text ("I want to learn it in a")
                                    .font(.system(size: 18, weight: .semibold))                      .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding([.top, .leading])
                                
                                
                                HStack(spacing: 12) {
                                    Button(action: {
                                        selectedTimeFrame = "Week"
                                    }) {
                                        Text("Week")
                                            .fontWeight(selectedTimeFrame == "Week" ? .semibold : .regular) // Semi-bold when selected
                                            .foregroundColor(selectedTimeFrame == "Week" ? .black : .orange) // Black text when selected
                                            .frame(width: 80, height: 40)
                                            .background(selectedTimeFrame == "Week" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                            .cornerRadius(6)
                                    }
                                    
                                    Button(action: {
                                        selectedTimeFrame = "Month"
                                    }) {
                                        Text("Month")
                                            .fontWeight(selectedTimeFrame == "Month" ? .semibold : .regular) // Semi-bold when selected
                                            .foregroundColor(selectedTimeFrame == "Month" ? .black : .orange) // Black text when selected
                                            .frame(width: 80, height: 40)
                                            .background(selectedTimeFrame == "Month" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                            .cornerRadius(6)
                                    }
                                    
                                    Button(action: {
                                        selectedTimeFrame = "Year"
                                    }) {
                                        Text("Year")
                                            .fontWeight(selectedTimeFrame == "Year" ? .semibold : .regular) // Semi-bold when selected
                                            .foregroundColor(selectedTimeFrame == "Year" ? .black : .orange) // Black text when selected
                                            .frame(width: 80, height: 40)
                                            .background(selectedTimeFrame == "Year" ? Color.orange : Color.gray.opacity(0.2)) // Orange background when selected
                                            .cornerRadius(6)
                                    }
                                }
                                .padding(.leading)
                            } //HStack
                        }
                        // Navigation to CurrentDayView
                        NavigationLink(destination: CurrentDay()) {
                                                Text("Start →")
                                                    .font(.system(size: 16, weight: .semibold))
                                                    .foregroundColor(.black)
                                                    .frame(width: 200, height: 50)
                                                    .background(Color.orange)
                                                    .cornerRadius(10)
                                            }
                        }
                    .padding(.bottom, 100)
                        .simultaneousGesture(TapGesture().onEnded {
                            // Set the flag to true so the main page doesn't appear again
                            isStart = true
                        })
                        
                        Spacer()
                    }
                    
                    
                }
            }
        }
    
    

#Preview {
    ContentView()
}

