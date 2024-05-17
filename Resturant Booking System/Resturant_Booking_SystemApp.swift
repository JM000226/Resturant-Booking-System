//
//  Resturant_Booking_SystemApp.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

@main
struct Resturant_Booking_SystemApp: App {
    @StateObject private var navigation = NavigationController()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: ReservationViewModel())  // Adjusted to accept a viewModel
                    .environmentObject(navigation)
            }
        }
    }
}
