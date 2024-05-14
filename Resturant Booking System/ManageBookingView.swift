//
//  ManageBookingView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

struct ManageBookingView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State private var bookingNumber = ""
    @State private var showingCancellationSuccess = false
    @State private var showingCancellationError = false

    var body: some View {
        VStack {
            TextField("Enter Booking Number", text: $bookingNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Cancel Booking", action: {
                // Trim and adjust for case sensitivity if necessary
                let trimmedBookingNumber = bookingNumber.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
                print("Attempting to cancel booking with number: \(trimmedBookingNumber)")
                print("Existing bookings: \(viewModel.reservations.map { $0.bookingNumber })")

                if viewModel.cancelReservation(with: trimmedBookingNumber) {
                    showingCancellationSuccess = true
                    bookingNumber = ""  // Clear the input field on success
                } else {
                    showingCancellationError = true
                }
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .alert(isPresented: $showingCancellationSuccess) {
            Alert(title: Text("Booking Cancelled"), message: Text("Your booking has been successfully cancelled."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showingCancellationError) {
            Alert(title: Text("Error"), message: Text("No booking found with that number."), dismissButton: .default(Text("OK")))
        }
        .padding()
    }
}


struct ManageBookingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ManageBookingView(viewModel: ReservationViewModel())
        }
    }
}


