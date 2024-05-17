//
//  FourthView.swift
//  Resturant Booking System
//
//  Created by Yuri on 13/5/2024.
//

import SwiftUI

struct FourthView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @EnvironmentObject var navigation: NavigationController
    
    var body: some View {
        VStack {
            Text("Betty's Burgers")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.pink)
            Text("Thank You!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.orange)
            Text("You should receive an email with the details of your reservation.")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            if let bookingNumber = viewModel.reservations.last?.bookingNumber {
                Text("Your Booking Number: \(bookingNumber)")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding()
                
                NavigationLink(destination: ContentView(viewModel: viewModel)) {
                    Text("Back to Home")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 2, x: 0, y: 1)
                }
            }
        }
    }
}
            
struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ReservationViewModel()
        FourthView(viewModel: viewModel)
            .environmentObject(NavigationController())
    }
}
