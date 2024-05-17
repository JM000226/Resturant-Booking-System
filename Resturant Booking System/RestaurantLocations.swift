//
//  RestaurantLocations.swift
//  Resturant Booking System
//
//  Created by Mac on 17/5/2024.
//

import Foundation
import MapKit

class RestaurantLocation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var id: UUID = UUID()
    var name: String

    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }

    var title: String? {
        return name
    }
}


// Location Data
let restaurantLocations: [RestaurantLocation] = [
    RestaurantLocation(name: "Sydney CBD", coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)),
    RestaurantLocation(name: "Bondi Beach", coordinate: CLLocationCoordinate2D(latitude: -33.8908, longitude: 151.2743)),
    RestaurantLocation(name: "Parramatta", coordinate: CLLocationCoordinate2D(latitude: -33.8151, longitude: 151.0011))
]
