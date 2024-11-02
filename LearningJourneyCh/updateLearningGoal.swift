import SwiftUI

struct UpdateLearningGoal: View {
    @State private var learningGoal: String = ""
    @FocusState private var focus: Bool
    @State private var selectedTimeFrame: String = "Month"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                
                HStack(spacing: 60) {
                    NavigationLink(destination: CurrentDayContentView(viewModel: CurrentDayViewModel(model: LearningJourneyModel()))) {
                        Text("< back")
                            .foregroundColor(.orange)
                            .frame(width: 59, height: 22)
                            .font(.system(size: 17, weight: .semibold))
                    }
                
                    Text("Learning goal")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 108, height: 22)
                
                    Button {
                        // Add action to update the learning goal here
                    } label: {
                        Text("Update")
                            .foregroundColor(.orange)
                            .frame(width: 59, height: 22)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                .padding(.bottom, 700)
                
                VStack(alignment: .leading) {
                    Text("I want to learn")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 50)
                    
                    TextField("Swift", text: $learningGoal)
                        .foregroundColor(.gray)
                        .font(.system(size: 17, weight: .regular))
                        .frame(width: 90, height: 22)
                        .focused($focus)
                        .accentColor(.orange)
                        .onAppear { focus = true }
                    
                    // Bottom line (underline)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color("Gray3"))
                    
                    Text("I want to learn it in")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .medium))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    HStack(spacing: 8) {
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
                    .padding(.bottom, 500)
                }
                .padding([.top, .leading])
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Renamed to avoid conflict
struct CurrentDayContentView: View {
    @ObservedObject var viewModel: CurrentDayViewModel
    
    var body: some View {
        Text("Current Day View") // Replace with actual content of CurrentDayView
    }
}

#Preview {
    UpdateLearningGoal()
}
