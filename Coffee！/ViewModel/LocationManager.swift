//
//  LocationManager.swift
//  Coffee！
//
//  Created by SyDGooDBoY on 14/5/2025.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationString: String = "Locating..."
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.requestWhenInUseAuthorization()          //
        manager.startUpdatingLocation()                  //
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        
        geocoder.reverseGeocodeLocation(loc) { [weak self] placemarks, _ in
            if let place = placemarks?.first {
                self?.locationString = [
                    place.locality, place.subLocality
                ].compactMap { $0 }.joined(separator: ", ")
            } else {
                self?.locationString =
                    String(format: "%.4f, %.4f",
                           loc.coordinate.latitude,
                           loc.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationString = "Location unavailable"
    }
}
