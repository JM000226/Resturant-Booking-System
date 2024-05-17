//
//  Reservation.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import Foundation

// Properties defining a reservation, immutably stored within a struct.
struct Reservation {
    var bookingNumber: String
    var selectedDate: Date
    var selectedTime: Date
    var selectedSeatLocation: String
    var numberOfGuests: Int
    var memo: String
}

