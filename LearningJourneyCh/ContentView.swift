//
//  ContentView.swift
//  LearningJourneyCh
//
//  Created by Aisha Asiri on 18/04/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnboarding = true
    @State private var currentDay: String = ""
    
    var body: some View {
        NavigationView {
            if !isOnboarding {
                Onboarding()
            } else {
                CurrentDay()
            }
        }
    }
}


#Preview {
    ContentView()
}
