//
//  ViewController.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/11/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit
import MapKit

class CoffeeMapViewController: UIViewController {
    
    let initialLocation = CLLocation(latitude: 28.538942, longitude: -81.381453)
    let regionRadius: CLLocationDistance = 1000
    
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Location Manager
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
        centerMapOnLocation(initialLocation)
    }
    
    override func viewDidAppear(animated: Bool) {
        locationManager.delegate = self
        // Set accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // Set distance filter
        locationManager.distanceFilter = 100
        // Start updating location
        locationManager.startUpdatingLocation()
    }

}

// MARK: Class Helpers
extension CoffeeMapViewController {
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: CLLocationManagerDelegate
extension CoffeeMapViewController: CLLocationManagerDelegate {
    
    
    
    
}