//
//  LeftitApp.swift
//  Leftit
//
//  Created by Emanuele Di Pietro on 22/03/24.
//

import SwiftUI

@main
struct LeftitApp: App {
    @StateObject var vm = LocationManager()
    var body: some Scene {
        WindowGroup {
            SearchableMap()
                .environmentObject(vm)
        }
    }
}
