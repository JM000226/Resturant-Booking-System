//
//  LocationManager.swift
//  Resturant Booking System
//
//  Created by Mac on 17/5/2024.
//

import CoreLocation

// LocationManager is responsible for handling location updates and errors using CoreLocation.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()  // Private instance of CLLocationManager to manage location services.
    @Published var currentLocation: CLLocation?  // Observable property to store the current location.

    override init() {
        super.init()
        locationManager.delegate = self  // Sets this instance as the delegate to receive location updates.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  // Sets the location accuracy to the best available.
        locationManager.requestWhenInUseAuthorization()  // Requests permission from the user to use location services while the app is in use.
        locationManager.startUpdatingLocation()  // Starts the process of receiving location updates.
    }
    
    // Callback function that updates the current location when new locations are available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first  // Updates currentLocation with the first location in the array.
    }
    
    // Callback function that handles errors encountered while updating locations.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")  // Logs any errors to the console.
    }
}
