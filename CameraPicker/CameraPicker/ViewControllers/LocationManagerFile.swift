//
//  UserLocationManager.swift
//  CameraPicker
//
//  Created by ilomidze on 04.05.21.
//

import Foundation
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    
    // setting locationManager for usage
    func prepUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
        locationManager?.delegate = self
    }
 
    // Needed for prepUserLocation - there is an initialization
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Found users location: \(location)")
        }
    }
    
    // Needed for prepUserLocation - there is an initialization (if it goes wrong)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Cant obtain users location: \(error.localizedDescription)")
    }
    
}
