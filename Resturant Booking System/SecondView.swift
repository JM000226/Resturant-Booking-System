//
//  SecondView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

struct SecondView: View {
    @ObservedObject var reservationViewModel: ReservationViewModel
    
    var body: some View {
        ZStack {
            Color("white").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Betty's Burgers")
                    .padding(.top, 20)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink)
                    .shadow(color: .gray, radius: 2, x: 0, y: 1)
                
                Text("Book a Table")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding()
                
                
                
                DatePicker("Select Date", selection: $reservationViewModel.selectedDate, displayedComponents: .date)
                    .padding()
                
                
                DatePicker("Select Time", selection: $reservationViewModel.selectedTime, displayedComponents: .hourAndMinute)
                    .padding()
                
                Picker("Store Location", selection: $reservationViewModel.selectedStoreLocation) {
                              Text("Sydney NSW").tag("Sydney Nsw")
                              Text("Another Location").tag("Another Location")
                          }
                          .pickerStyle(SegmentedPickerStyle())
                          .padding()
                    
                    Picker("Seat Location", selection: $reservationViewModel.selectedSeatLocation) {
                        Text("Window Seat").tag("Window Seat")
                        Text("Middle Seat").tag("Middle Seat")
                        Text("Aisle Seat").tag("Aisle Seat")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Stepper("Number of Guests: \(reservationViewModel.numberOfGuests)", value: $reservationViewModel.numberOfGuests, in: 1...10)
                        .padding()
                    
                    NavigationLink(destination: ThirdView(reservationViewModel: reservationViewModel)) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 2, x: 0, y: 1)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    struct SecondView_Previews: PreviewProvider {
        static var previews: some View {
            SecondView(reservationViewModel: ReservationViewModel())
        }
    }

