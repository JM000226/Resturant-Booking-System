//
//  ThirdView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

struct ThirdView: View {
    @ObservedObject var reservationViewModel: ReservationViewModel
    @State private var navigateToFourthView = false // Controls navigation to the Fourth View
    @State private var isActive = false // Manages whether FourthView is active or not
    @State private var showingError = false // Controls the display of error messages
    @State private var errorMessage = "" // Stores the error message text

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                header
                form
                Spacer()
            }
            .padding()
            .background(navigationLink)
        }
    }

    private var header: some View {
        VStack {
            Text("Betty's Burgers")
                .padding(.top, 20)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.pink)
                .shadow(color: .gray, radius: 2, x: 0, y: 1)
            
            Text("Confirm Reservation")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.orange)
                .padding()
        }
    }

    private var form: some View {
        Group {
            Group {
                Text("Selected Store Location: ").bold()
                + Text(reservationViewModel.selectedStoreLocation?.title ?? "Not selected")
            }
            Group {
                Text("Selected Date: ").bold()
                + Text("\(formattedDate(reservationViewModel.selectedDate))")
            }
            Group {
                Text("Selected Time: ").bold()
                + Text("\(formattedTime(reservationViewModel.selectedTime))")
            }
            Group {
                Text("Selected Seat Location: ").bold()
                + Text("\(reservationViewModel.selectedSeatLocation)")
            }
            Group {
                Text("Number of Guests: ").bold()
                + Text("\(reservationViewModel.numberOfGuests)")
            }
            
            if showingError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            TextField("Name", text: $reservationViewModel.name)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Phone Number", text: $reservationViewModel.phoneNumber)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Email", text: $reservationViewModel.email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Memo (Optional)", text: $reservationViewModel.memo)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            bookNowButton
        }
    }

    private var bookNowButton: some View {
        Button("Book Now", action: bookNowAction)
            .bold()
            .foregroundColor(.white)
            .padding()
            .background(Color.pink)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 2, x: 0, y: 1)
            .padding(.bottom, 20)
    }

    private var navigationLink: some View {
        NavigationLink(destination: FourthView(viewModel: reservationViewModel), isActive: $navigateToFourthView) {
            EmptyView()
        }
    }

    private func bookNowAction() {
        if reservationViewModel.confirmReservation() {
            navigateToFourthView = true
            showingError = false
        } else {
            errorMessage = "Please fill out the correct details"
            showingError = true
            navigateToFourthView = false
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formattedTime(_ time: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}

struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView(reservationViewModel: ReservationViewModel())
    }
}
