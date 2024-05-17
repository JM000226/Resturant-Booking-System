//
//  NavigationController.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

// Tracks navigation state changes across the app.
class NavigationController: ObservableObject {
    @Published var isActive: Bool = false
}
