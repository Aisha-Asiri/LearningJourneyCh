import Foundation
import SwiftUI

struct DayData {
    let date: Date
    var isLogged: Bool = false
    var isFrozen: Bool = false
}

class LearningJourneyModel: ObservableObject {
    @Published var selectedDay = ""
    @Published var learningGoal = "Swift"
    @Published var streakCount = 0
    @Published var freezeCount = 0
    @Published var selectedDate: Date = Date()
    @Published var loggedDates: Set<Date> = []
    @Published var frozenDates: Set<Date> = []
    @Published var lastLoggedDate: Date = Date()
    @Published var selectedTimeFrame: String = "Month"  // Added this line
}

class CurrentDayViewModel: ObservableObject {
    @Published var model: LearningJourneyModel
    
    init(model: LearningJourneyModel) {
        self.model = model
    }
    
    var currentMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: model.selectedDate)
    }
    
    var currentYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: model.selectedDate)
    }
    
    var currentDay: Int {
        Calendar.current.component(.day, from: model.selectedDate)
    }
    
    func logDay() {
        if !isSelectedDateLogged && !isSelectedDateFrozen {
            model.loggedDates.insert(model.selectedDate)
            model.streakCount += 1
        }
    }
    
    func freezeDay() {
        if !isSelectedDateFrozen && !isSelectedDateLogged && model.freezeCount < maxFreezesAllowed {
            model.frozenDates.insert(model.selectedDate)
            model.freezeCount += 1
        }
    }
    
    var maxFreezesAllowed: Int {
        switch model.selectedTimeFrame {
        case "Week":
            return 2
        case "Month":
            return 6
        case "Year":
            return 60
        default:
            return 6
        }
    }
    
    var isSelectedDateLogged: Bool {
        model.loggedDates.contains(model.selectedDate)
    }
    
    var isSelectedDateFrozen: Bool {
        model.frozenDates.contains(model.selectedDate)
    }
}


