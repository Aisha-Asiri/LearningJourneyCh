//
//  updateLearningGoal.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct updateLearningGoal: View {
    @State private var learningGoal: String = ""
    @FocusState private var focus: Bool
    @State private var selectedTimeFrame: String = "Month"
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
        
            VStack(alignment: .leading) {
                Text ("I want to learn")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 50)
                TextField("Swift", text: $learningGoal)
                    .foregroundColor(.gray)
                    .font(.system(size:17, weight: .regular))
                    .frame(width: 90, height: 22)
                    .focused($focus)
                    .accentColor(.orange)
                    .onAppear() {focus = true}
                // Bottom line (underline)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color("Gray3"))
                Text ("I want to learn it in")
                    .foregroundColor(.white)
                    .font(.system(size:16, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                HStack(spacing: 8) {
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
                    } //HStack
                Spacer()
                } //VStack
            .padding([.top, .leading])
                } //ZStack
        
        .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                   HStack (spacing: 50) {
                       Text("Learning goal")
                           .font(.system(size: 17, weight: .semibold))
                           .foregroundColor(.white)
                           .frame(width: 108, height: 22)
                       
                       Button {
                           // Action
                       } label: {
                           Text("Update")
                               .foregroundColor(.orange)
                               .frame(width: 59, height: 22)
                               .font(.system(size: 17, weight: .semibold))
                       }
                       .padding(.leading, 20) // Adjust if needed
                       
                   }
               }
           }
           .navigationBarTitleDisplayMode(.inline)
       }
            }
    
#Preview {
    updateLearningGoal()
}

