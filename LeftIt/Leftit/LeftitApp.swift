//
//  LeftitApp.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 22/03/24.
//

import SwiftUI
import SwiftData

@main
struct LeftitApp: App {
    @StateObject var vm = LocationManager()
    private let container: ModelContainer
    
    @AppStorage ("isOnboarding") var isOnboarding: Bool = true
    
    init() {
        do {
            container = try ModelContainer(for: LocationItem.self, configurations: ModelConfiguration())
        } catch {
            fatalError("Fatal Error: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                Onboarding()
                    .onDisappear { isOnboarding = false }
                    .environmentObject(vm)
            } else {
                ContentView()
                    .environmentObject(vm)
            }
        }
        .modelContainer(container)
    }
}
