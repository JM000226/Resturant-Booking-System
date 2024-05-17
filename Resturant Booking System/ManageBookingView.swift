//
//  ManageBookingView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

// A view for managing and cancelling bookings.
struct ManageBookingView: View {
    // The view model for handling reservation data.
    @ObservedObject var viewModel: ReservationViewModel
    // State variable to store the booking number entered by the user.
    @State private var bookingNumber = ""
    // State variable to control the display of the alert.
    @State private var showingAlert = false
    // State variable to set the alert's title.
    @State private var alertTitle = ""
    // State variable to set the alert's message.
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            // Text field for entering the booking number.
            TextField("Enter Booking Number", text: $bookingNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Button to cancel the booking.
            Button("Cancel Booking", action: cancelBooking)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        // Display an alert based on the state variables.
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding()
    }

    // Function to handle booking cancellation.
    private func cancelBooking() {
        // Trim and uppercase the booking number for consistency.
        let trimmedBookingNumber = bookingNumber.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        // Check if the reservation can be cancelled.
        if viewModel.cancelReservation(with: trimmedBookingNumber) {
            // Update the alert for successful cancellation.
            alertTitle = "Booking Cancelled"
            alertMessage = "Your booking has been successfully cancelled."
            bookingNumber = ""  // Clear the input field on success.
        } else {
            // Update the alert for an error.
            alertTitle = "Error"
            alertMessage = "No booking found with that number."
        }
        // Show the alert.
        showingAlert = true
    }
}

struct ManageBookingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ManageBookingView(viewModel: ReservationViewModel())
        }
    }
}
