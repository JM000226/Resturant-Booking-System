//
//  FirstView.swift
//  Resturant Booking System
//
//  Created by Mac on 17/5/2024.
//

import SwiftUI
import MapKit

struct FirstView: View {
    @ObservedObject var viewModel: ReservationViewModel
    @State private var showingLocationSelection = false  // State to handle showing the location picker

    var body: some View {
        VStack {
            Text("Select your preferred location")
                .font(.headline)
                .padding()

            MapView(selectedLocation: $viewModel.selectedStoreLocation, annotations: viewModel.restaurantLocations)
                .frame(height: 400)

            Button(action: {
                showingLocationSelection = true
            }) {
                Text("Choose a Location")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            .actionSheet(isPresented: $showingLocationSelection) {
                ActionSheet(title: Text("Select a Location"), buttons: locationButtons())
            }

            if let selectedLocation = viewModel.selectedStoreLocation, let locationName = selectedLocation.title {
                Text("Selected Location: \(locationName)")
                    .font(.title2)
                    .padding()

                NavigationLink(destination: SecondView(reservationViewModel: viewModel)) {
                    Text("Proceed with \(locationName)")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .accessibility(label: Text("Proceed with booking at \(locationName)"))
                }
                .padding()
            }
            Spacer()
        }
        .navigationBarTitle("Select a Store", displayMode: .inline)
    }

    private func locationButtons() -> [ActionSheet.Button] {
        var buttons = viewModel.restaurantLocations.map { location in
            ActionSheet.Button.default(Text(location.title ?? "Unknown")) {
                viewModel.selectedStoreLocation = location
            }
        }
        buttons.append(.cancel())
        return buttons
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(viewModel: ReservationViewModel())
    }
}
