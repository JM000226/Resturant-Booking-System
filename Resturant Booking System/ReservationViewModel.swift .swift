//
//  ReservationViewModel.swift .swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import Foundation
import MapKit

class ReservationViewModel: ObservableObject {
    @Published var reservations: [Reservation] = []
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date = Date()
    @Published var restaurantLocations: [RestaurantLocation] = [
        RestaurantLocation(name: "Sydney CBD", coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)),
        RestaurantLocation(name: "Bondi Beach", coordinate: CLLocationCoordinate2D(latitude: -33.8908, longitude: 151.2743)),
        RestaurantLocation(name: "Parramatta", coordinate: CLLocationCoordinate2D(latitude: -33.8151, longitude: 151.0011))
    ]
    @Published var selectedStoreLocation: RestaurantLocation?
    @Published var selectedSeatLocation: String = "Window Seat"
    @Published var numberOfGuests: Int = 1
    @Published var memo: String = ""
    
    // Method to select a location, which updates the current location
    func selectLocation(_ location: RestaurantLocation) {
        self.selectedStoreLocation = location
    }

    // Verifies input fields and adds a new reservation to the list if valid.
    func confirmReservation() -> Bool {
        guard !name.isEmpty, !phoneNumber.isEmpty, phoneNumber.isPhoneNumber, !email.isEmpty, email.isValidEmail else {
            return false
        }
        let newReservation = Reservation(
            bookingNumber: generateBookingNumber(selectedDate: selectedDate),
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedSeatLocation: selectedSeatLocation,
            numberOfGuests: numberOfGuests,
            memo: memo
        )
        reservations.append(newReservation)
        return true
    }
    
    // Generates a unique booking number based on the date and the first letter of the user's name.
    func generateBookingNumber(selectedDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let datePart = dateFormatter.string(from: selectedDate)
        let namePart = name.prefix(1).uppercased()
        return "\(namePart)\(datePart)"
    }

    // Removes a reservation from the list based on its booking number.
    func cancelReservation(with bookingNumber: String) -> Bool {
        if let index = reservations.firstIndex(where: { $0.bookingNumber == bookingNumber }) {
            reservations.remove(at: index)
            return true
        }
        return false
    }
}

extension String {
    // Validates if a string represents a phone number.
    var isPhoneNumber: Bool {
        self.count >= 10 && self.allSatisfy { $0.isNumber }
    }
    
    // Validates if a string represents a valid email address.
    var isValidEmail: Bool {
        self.contains("@") && self.contains(".")
    }
}
