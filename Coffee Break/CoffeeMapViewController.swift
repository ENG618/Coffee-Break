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
    
    private let ClientID = "OLXCMXPWEIJ4JXBCWMD5JIPMXQGX02S15LHZHIHZMRIXCFG2"
    private let ClientSecret = "0CBC51OH2ZVGSZYWYDJ5WSUWLLSIH5AHRDZUNYJRBCCTZNKN"
    
    var userLocation: CLLocation!
    let regionRadius: CLLocationDistance = 16093.4 // 10 miles = 16093.4 meters
    
    var coffeeShops: [CoffeeShop] = []
    
    @IBOutlet var mapView: MKMapView!
    @IBAction func centerMap(sender: AnyObject) {
        checkLocationAuthorizationStatus()
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Location Manager
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        switch authStatus {
        case .AuthorizedWhenInUse:
            mapView.showsUserLocation = true
        case .AuthorizedAlways:
            println("Always Authorized")
            mapView.showsUserLocation = true
        case .Restricted:
            println("Restricted")
            showLocationRequiredAlert()
        case .Denied:
            println("Denied")
            showLocationRequiredAlert()
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        locationManager.delegate = self
        // Set accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // Set distance filter
        locationManager.distanceFilter = 100
        // Start updating location
        locationManager.startUpdatingLocation()
        //        locationManager.startMonitoringSignificantLocationChanges()
    }
    
}

// MARK: Class Helpers
extension CoffeeMapViewController {
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func createPinsFromArray(locationsArray: [CoffeeShop]) {
        for shop in locationsArray {
            addPinToMap(shop)
        }
        
    }
    
    func addPinToMap(shop: CoffeeShop) {
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = shop.coordinate
        newPin.title = shop.title
        mapView.addAnnotation(newPin)
        
    }
    
    func showLocationRequiredAlert() {
        let alertController = UIAlertController(title: "Location Access Required", message: "Go to settings and allow location access while using the app, so we can locate coffee shops near you.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Default, handler: {(_) -> Void in
            let settingsUrl = NSURL(string: UIApplicationOpenSettingsURLString)
            if let url = settingsUrl {
                UIApplication.sharedApplication().openURL(url)
            }
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

// MARK: CLLocationManagerDelegate
extension CoffeeMapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.last as? CLLocation {
            
            // Update users current location
            userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            // Center map on users current location
            centerMapOnLocation(userLocation)
            searchLocation(userLocation)
        }
    }
}

// MARK: Search
extension CoffeeMapViewController {
    
    func searchLocation(location: CLLocation) {
        let lat = String(stringInterpolationSegment: location.coordinate.latitude)
        let lng = String(stringInterpolationSegment: location.coordinate.longitude)
        println("Latitude: \(lat), Longitude: \(lng)")
        searchFoursquare(lat, lng: lng)
        
        // Stop
        locationManager.stopUpdatingLocation()
        // Start segnificant changes
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    private func searchFoursquare(lat: String, lng: String) {
        var searchUrl = NSURL(string: "http://api.foursquare.com/v2/venues/search?client_id=\(ClientID)&client_secret=\(ClientSecret)&ll=\(lat),\(lng)&radius=16093&query=coffee&openNow=1&v=20150501&m=foursquare")
        
        // Create session & task
        let session = NSURLSession.sharedSession()
        let sessionTask = session.dataTaskWithURL(searchUrl!, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                println("Error: \(error)")
            } else {
                self.parseJSON(self.jsonFromData(data))
            }
        })
        // Run task
        sessionTask.resume()
    }
    
    private func jsonFromData(data: NSData) -> NSDictionary {
        var jsonError: NSError?
        let jsonData: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        
        return jsonData
    }
    
    private func parseJSON(jsonData: NSDictionary) {
        
        var parsedVenues: [CoffeeShop] = []
        
        let response = jsonData["response"] as! NSDictionary
        let venues = response["venues"] as! [NSDictionary]
        
        for venue in venues {
            
            // ID
            let venueID = venue["id"] as! String
            
            // Name
            let venueName = venue["name"] as! String
            
            // Location Dictionary
            let locationDictionary = venue["location"] as! NSDictionary
            
            // Lat Lng
            let lat = locationDictionary["lat"] as! CLLocationDegrees
            let lng = locationDictionary["lng"] as! CLLocationDegrees
            
            // Create istance of CoffeeShop
            let shop = CoffeeShop(id: venueID, title: venueName, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
            // Append to parsed array
            parsedVenues.append(shop)
            
            let CMVC = CoffeeMapViewController()
        }
        
        // Pass to CoffeeMapViewController to add pins to map
        createPinsFromArray(parsedVenues)
        
    }
}






