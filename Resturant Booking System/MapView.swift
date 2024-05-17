//
//  MapView.swift
//  Resturant Booking System
//
//  Created by Mac on 17/5/2024.
//

import SwiftUI
import MapKit

// A SwiftUI wrapper for MKMapView
struct MapView: UIViewRepresentable {
    // Binding to the selected restaurant location
    @Binding var selectedLocation: RestaurantLocation?
    // Array of restaurant locations to be annotated on the map
    let annotations: [RestaurantLocation]
    
    // Create and configure the MKMapView instance
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.addAnnotations(annotations)
        mapView.setRegion(calculateFittingRegion(for: annotations), animated: true)
        return mapView
    }

    // Update the MKMapView instance with new data
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
        uiView.setRegion(calculateFittingRegion(for: annotations), animated: true)
    }

    // Create a Coordinator instance to act as the delegate for MKMapView
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Calculate the region that fits all annotations
    private func calculateFittingRegion(for annotations: [RestaurantLocation]) -> MKCoordinateRegion {
        // Initialize the min and max coordinates
        var minLat = 90.0
        var maxLat = -90.0
        var minLon = 180.0
        var maxLon = -180.0

        // Iterate over all annotations to find the min and max coordinates
        for location in annotations {
            minLat = min(minLat, location.coordinate.latitude)
            maxLat = max(maxLat, location.coordinate.latitude)
            minLon = min(minLon, location.coordinate.longitude)
            maxLon = max(maxLon, location.coordinate.longitude)
        }

        // Calculate the center and span of the region
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.3,  // Adding some padding
            longitudeDelta: (maxLon - minLon) * 1.3  // Adding some padding
        )

        // Return the calculated region
        return MKCoordinateRegion(center: center, span: span)
    }
    
    // Coordinator class to act as the delegate for MKMapView
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        // Initialize with the parent MapView instance
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // Handle the selection of an annotation view
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // Cast the annotation to RestaurantLocation and update the binding
            if let restaurantLocation = view.annotation as? RestaurantLocation {
                parent.selectedLocation = restaurantLocation
            }
        }
    }
}

