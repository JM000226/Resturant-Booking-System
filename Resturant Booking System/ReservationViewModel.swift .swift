//
//  ReservationViewModel.swift .swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservations: [Reservation] = []
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var email: String = ""
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: Date = Date()
    @Published var selectedStoreLocation: String = "Sydney NSW"
    @Published var selectedSeatLocation: String = "Window Seat"
    @Published var numberOfGuests: Int = 1

    func confirmReservation() -> Bool {
        guard !name.isEmpty, !phoneNumber.isEmpty, phoneNumber.isPhoneNumber, !email.isEmpty, email.isValidEmail else {
            return false
        }
        let newReservation = Reservation(
            bookingNumber: generateBookingNumber(selectedDate: selectedDate),
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            selectedSeatLocation: selectedSeatLocation,
            numberOfGuests: numberOfGuests
        )
        reservations.append(newReservation)
        return true
    }
    
    func generateBookingNumber(selectedDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let datePart = dateFormatter.string(from: selectedDate)
        let namePart = name.prefix(1).uppercased() 
        return "\(namePart)\(datePart)"
    }

    
    func cancelReservation(with bookingNumber: String) -> Bool {
        if let index = reservations.firstIndex(where: { $0.bookingNumber == bookingNumber }) {
            reservations.remove(at: index)
            return true
        }
        return false
    }
}

extension String {
    var isPhoneNumber: Bool {
        self.count >= 10 && self.allSatisfy { $0.isNumber }
    }
    
    var isValidEmail: Bool {
        self.contains("@") && self.contains(".")
    }
}



