// ContentView.swift
import SwiftUI

struct ContentView: View {
    @State private var learningGoal: String = ""
    @FocusState private var focus: Bool
    @AppStorage("selectedTimeFrame") var selectedTimeFrame: String = "Month"
    @AppStorage("isStart") var isStart: Bool = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black).ignoresSafeArea(.all)
                VStack(spacing: 50) {
                    // Flame Icon
                    Text("🔥")
                        .fontWeight(.regular)
                        .frame(width: 150, height: 100)
                        .font(.system(size: 52))
                        .background(
                            Color("Gray5")
                                .frame(width: 118, height: 118)
                                .clipShape(Ellipse())
                        )
                    
                    VStack {
                        Text("Hello Learner!")
                            .font(.system(size:32, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        
                        Text("This app will help you learn everyday")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                    
                    // Input for Learning Goal
                    VStack(alignment: .leading) {
                        Text("I want to learn")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.leading)
                        
                        ZStack(alignment: .bottom) {
                            TextField("Swift", text: $learningGoal)
                                .foregroundColor(Color("Gray3"))
                                .font(.system(size: 17, weight: .regular))
                                .padding(.bottom, 5)
                                .focused($focus)
                                .accentColor(.orange)
                                .onAppear { focus = true }
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color("Gray3"))
                        }
                        .padding(.horizontal)
                        
                        // Timeframe selection
                        Text("I want to learn it in a")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding([.top, .leading])
                        
                        HStack(spacing: 12) {
                            ForEach(["Week", "Month", "Year"], id: \.self) { timeFrame in
                                Button(action: {
                                    selectedTimeFrame = timeFrame
                                }) {
                                    Text(timeFrame)
                                        .fontWeight(selectedTimeFrame == timeFrame ? .semibold : .regular)
                                        .foregroundColor(selectedTimeFrame == timeFrame ? .black : .orange)
                                        .frame(width: 80, height: 40)
                                        .background(selectedTimeFrame == timeFrame ? Color.orange : Color.gray.opacity(0.2))
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.leading)
                    }
                    
                    // Navigation to CurrentDay View
                    NavigationLink(destination: CurrentDay(viewModel: CurrentDayViewModel(model: LearningJourneyModel()))) {
                        Text("Start →")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        isStart = true
                    })
                    
                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}
struct CurrentDay: View {
    @ObservedObject var viewModel: CurrentDayViewModel
    
    var body: some View {
        VStack {
            Text("Today's Learning Goal")
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.model.learningGoal)
                .font(.title)
                .foregroundColor(.orange)
                .padding()
            
            Text("Timeframe: \(viewModel.model.selectedTimeFrame)")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("Current Day", displayMode: .inline)
    }
}


#Preview {
    ContentView()
}
