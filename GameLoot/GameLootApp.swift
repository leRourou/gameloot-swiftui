//
//  GameLootApp.swift
//  GameLoot
//
//  Created by Axel ROUQUETTE on 1/19/24.
//

import SwiftUI

@main
struct GameLootApp: App {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isOnboardingDone {
                ContentView()
                Button("setOnboarding") {
                    isOnboardingDone = false
                }
            } else {
                OnboardingView(setOnboardingDone: {self.isOnboardingDone = true})
            }
        }
    }
}
