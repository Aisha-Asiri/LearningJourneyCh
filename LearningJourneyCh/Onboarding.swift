import SwiftUI

struct Onboarding: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @FocusState private var focus: Bool

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                VStack(spacing: 50) {
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
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        
                        Text("This app will help you learn everyday")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color("Gray3"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }

                    // Input for Learning Goal
                    VStack {
                        Text("I want to learn")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        ZStack(alignment: .bottom) {
                            TextField("Swift", text: $viewModel.learningGoal)
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
                    }
                    
                    // Timeframe selection
                    VStack(alignment: .leading) {
                        Text("I want to learn it in a")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .leading])
                        
                        HStack(spacing: 12) {
                            ForEach(["Week", "Month", "Year"], id: \.self) { timeFrame in
                                Button(action: {
                                    viewModel.setTimeFrame(timeFrame)
                                }) {
                                    Text(timeFrame)
                                        .fontWeight(viewModel.selectedTimeFrame == timeFrame ? .semibold : .regular)
                                        .foregroundColor(viewModel.selectedTimeFrame == timeFrame ? .black : .orange)
                                        .frame(width: 80, height: 40)
                                        .background(viewModel.selectedTimeFrame == timeFrame ? Color.orange : Color.gray.opacity(0.2))
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .padding(.leading)
                    }

                    // Navigation to a view showing CurrentDayViewModel
                    NavigationLink(destination: CurrentDayView(viewModel: CurrentDayViewModel(model: LearningJourneyModel()))) {
                        Text("Start →")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 200, height: 50)
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.markAsStarted()
                    })
                    
                    Spacer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

class OnboardingViewModel: ObservableObject {
    @AppStorage("learningGoal") var learningGoal: String = "Swift"
    @AppStorage("selectedTimeFrame") var selectedTimeFrame: String = "Month"
    @AppStorage("isStart") var isStart: Bool = true
    
    @Published var isFocused: Bool = false
    
    func updateLearningGoal(_ goal: String) {
        learningGoal = goal
    }
    
    func setTimeFrame(_ timeFrame: String) {
        selectedTimeFrame = timeFrame
    }
    
    func markAsStarted() {
        isStart = true
    }
}

struct CurrentDayView: View {
    @ObservedObject var viewModel: CurrentDayViewModel
    
    var body: some View {
        Text("Current Day View") // Update with actual UI for CurrentDayView
    }
}

#Preview {
    Onboarding()
}

