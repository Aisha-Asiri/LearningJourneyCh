//
//  CurrentDay.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct CurrentDay: View {
    @State private var selectedDay: String = ""
    @State private var learningGoal: String = "Swift"
    @State private var streakCount: Int = 0
    @State private var freezeCount: Int = 0
    @State private var currentDate: Date = Date() // The current date
    @State private var selectedDate: Date = Date()  // Keep track of selected date as Date
    @State private var currentWeekStart: Date = Calendar.current.startOfWeek(for: Date())!
    // New state variable to track if today is logged as learned
    @State private var isLoggedToday: Bool = false
    @State private var isFrozen: Bool = false
    @State private var loggedDates: Set<Date> = [] // Track logged dates as learned
    @State private var frozenDates: Set<Date> = [] // Track frozen dates
    @AppStorage("selectedTimeFrame") var selectedTimeFrame: String = "Month"
    @State private var lastLoggedDate: Date = Date() // Keep track of the last date logged as learned

    private var maxFreezesAllowed: Int {
        switch selectedTimeFrame {
        case "Week":
            return 2
        case "Month":
            return 6
        case "Year":
            return 60
        default:
            return 6 // Default to "Month"
        }
    }

    
    private var isSelectedDateFrozen: Bool {
        frozenDates.contains(selectedDate)
    }

    private var isSelectedDateLogged: Bool {
        loggedDates.contains(selectedDate)
    }
    
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
    // Reset streak if more than 32 hours have passed since the last logged day
        private func checkStreakTimeout() {
            if Date().timeIntervalSince(lastLoggedDate) > 32 * 60 * 60 {
                streakCount = 0
            }
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
                                .font(.system(size:14, weight: .regular))
                                .foregroundColor(Color("Gray3"))
                            Text("Learning \(learningGoal)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        // NavigationLink for the flame image
                        NavigationLink(destination: updateLearningGoal()) {
                            Text ("🔥")
                                .fontWeight(.regular)
                                .frame(width: 25, height: 32)
                                .background(
                                    Color("Gray5")
                                        .frame(width: 44, height: 44)
                                        .clipShape(Circle())
                                )
                                .padding()
                        }
                    }
                    .padding(.top)
                    
                    
                    // Calendar Section
                    VStack(spacing:12) {
                        // Calendar
                        HStack {
                            Text("\(currentMonth) \(currentYear)")
                                .font(.system(size:17, weight: .semibold))
                                .foregroundColor(.white)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.orange)
                                .font(.system(size: 13, weight: .bold))
                            Spacer()
                            
                            HStack(spacing: 10) {
                                Button(action: {
                                    // Move to the previous week
                                    currentWeekStart = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: currentWeekStart) ?? currentWeekStart
                                }) {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.orange)
                                }
                                Button(action: {
                                    // Move to the next week
                                    currentWeekStart = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: currentWeekStart) ?? currentWeekStart
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.orange)
                                }
                            }
                            .font(.system(size: 20, weight: .medium))
                        }
                        .padding([.top, .leading, .trailing])
                        
                        
                        // Days of the Week Header
                        HStack {
                            ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { day in
                                Text(day)
                                    .font(.subheadline)
                                    .foregroundColor(isToday(day) ? .white : Color("Gray3"))
                                    .fontWeight(isToday(day) ? .bold : .regular)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.horizontal)
                        .font(.system(size: 13, weight: .semibold))
                        
                        // Days of the current week
                        HStack(spacing: 12) {
                            ForEach(0..<7, id: \.self) { offset in
                                let dayDate = Calendar.current.date(byAdding: .day, value: offset, to: currentWeekStart)!
                                DateCircle(
                                    dayDate: dayDate,
                                    isSelected: Calendar.current.isDate(dayDate, inSameDayAs: selectedDate),
                                    isLogged: loggedDates.contains(dayDate),
                                    isFrozen: frozenDates.contains(dayDate)
                                )
                                .onTapGesture {
                                    selectedDate = dayDate
                                }
                            }
                        }
                        Divider()
                            .frame(height: 1)
                            .overlay(Color("Gray3"))
                            .padding(.horizontal)
                        
                        
                        
                        // Streak & Freeze Count
                        HStack {
                            VStack {
                                Text("\(streakCount) 🔥")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("Day streak")
                                    .foregroundColor(Color("Gray3"))
                            }
                            .frame(maxWidth: .infinity)
                            Divider()
                                .frame(width: 1)
                                .overlay(Color("Gray3"))
                            
                            VStack {
                                Text("\(freezeCount)🧊")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("Day freezed")
                                    .foregroundColor(Color("Gray3"))
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding([.leading, .bottom, .trailing])
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color("Gray3"), lineWidth: 1)
                            .background(Color("darkBackground"))
                    )
                    .padding(.horizontal)
                    
                    // Log Button
                    Button(action: {
                        // Action for log button
                        if !isSelectedDateLogged && !isSelectedDateFrozen {
                                loggedDates.insert(selectedDate)
                                streakCount += 1
                            }
                    }) {
                        Text(isSelectedDateFrozen ? "Day              Freezed" : (isSelectedDateLogged ? "Learned\nToday" : "Log today\nas Learned"))
                                .font(.system(size: 41, weight: .semibold))
                                .foregroundColor(isSelectedDateFrozen ? .blue : (isSelectedDateLogged ? .orange : .black))
                                .multilineTextAlignment(.center)
                                .frame(width: 320, height: 320)
                                .background(
                                    Circle()
                                        .fill(isSelectedDateFrozen ? Color.blue.opacity(0.3) : (isSelectedDateLogged ? Color.orange.opacity(0.3) : Color.orange))
                                )

                    }
                    .disabled(isSelectedDateLogged || isSelectedDateFrozen)
                    .padding(.top)
                    
                    // Freeze Button
                    VStack {
                        Button(action: {
                                if !isSelectedDateFrozen && !isSelectedDateLogged && freezeCount < maxFreezesAllowed {
                                    frozenDates.insert(selectedDate)
                                    freezeCount += 1
                                }
                        }) {
                            Text("Freeze Day")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor((isSelectedDateLogged || isSelectedDateFrozen || freezeCount >= maxFreezesAllowed) ? .gray : .blue)
                                        .padding()
                                        .frame(width: 200)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill((isSelectedDateLogged || isSelectedDateFrozen || freezeCount >= maxFreezesAllowed) ? Color("Gray5") : Color("light blue"))
                                        )
                            
                        }
                        .disabled(isSelectedDateLogged || isSelectedDateFrozen || freezeCount >= maxFreezesAllowed)

                            Text("\(freezeCount) out of \(maxFreezesAllowed) freezes used")
                                .font(.caption)
                                .foregroundColor(Color("Gray3"))
                        }
                          
                    
                    Spacer()
                } //VStack
            } //ZStack
        }
        .navigationBarBackButtonHidden(true)
        
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

struct DateCircle: View {
    let dayDate: Date
    let isSelected: Bool
    let isLogged: Bool
    let isFrozen: Bool

    var body: some View {
        Text("\(Calendar.current.component(.day, from: dayDate))")
            .foregroundColor(isToday(dayDate) ? .white : .white)
            .font(.headline)
            .padding(.horizontal, 8)
            .background(
                Circle()
                    .fill(isLogged ? Color.orange.opacity(0.7) : (isFrozen ? Color.blue.opacity(0.7) : Color.clear))
                    .frame(width: 44, height: 44)
            )
    }

    private func isToday(_ date: Date) -> Bool {
        return Calendar.current.isDateInToday(date)
    }
}
    

extension Calendar {
    func startOfWeek(for date: Date) -> Date? {
        return self.dateInterval(of: .weekOfYear, for: date)?.start
    }
    
    func formattedMonthAndYear(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: date)
    }
}

private func isToday(_ day: String) -> Bool {
    // Get today's day in short form (e.g., "SUN", "MON", etc.)
    let today = Calendar.current.shortWeekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1].uppercased()
    return day == today
}

#Preview {
    CurrentDay()
}
