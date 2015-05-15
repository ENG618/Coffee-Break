//
//  CoffeeMapViewController.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/11/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit
import MapKit

class CoffeeMapViewController: UIViewController {
    
    let search = Search()
    let initialLocation = CLLocation(latitude: 28.538942, longitude: -81.381453)
    var userLocation: CLLocation!
    let regionRadius: CLLocationDistance = 16093.4 // 10 miles = 16093.4 meters
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Location Manager
    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            // TODO: Show alert that location is required
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
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addCoffeeShopPins() {
        search.searchLocation(userLocation)
    }
    
    class func createPinsFromArray(locationsArray: [CoffeeShop]) {
        for shop in locationsArray {
            println(shop.title)
            // TODO: Create pin for each shop
        }
    }
}

// MARK: CLLocationManagerDelegate
extension CoffeeMapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        // Update users current location
        userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        // Center map on users current location
        centerMapOnLocation(userLocation)
        
        addCoffeeShopPins()
        
    }
}






