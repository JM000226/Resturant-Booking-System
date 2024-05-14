//
//  ContentView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ReservationViewModel

    var body: some View {
        NavigationView { 
            VStack(alignment: .leading, spacing: 20.0) {
                Image("Betty's Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(15)

                HStack {
                    Text("Betty's Burgers")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.pink)

                    Spacer()

                    VStack {
                        HStack {
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.fill")
                            Image(systemName: "star.leadinghalf.fill")
                        }
                        .foregroundColor(.blue)
                        .font(.caption)
                    }
                }
                Text("Looking for Fresh and Tasty Burgers?")
                    .font(.headline)
                    .foregroundColor(Color(hue: 0.132, saturation: 0.61, brightness: 0.981))

                HStack {
                    Spacer()
                    Image(systemName: "fork.knife")
                }
                .foregroundColor(.blue)
                .font(.caption)

                VStack {
                    NavigationLink(destination: SecondView(reservationViewModel: viewModel)
                        .padding(1.0)) {
                        Text("Book Now!")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: ManageBookingView(viewModel: viewModel)) {
                        Text("Manage Booking")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            
            .padding()
        } 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ReservationViewModel())
    }
}




