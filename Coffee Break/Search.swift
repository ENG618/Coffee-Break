//
//  Search.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/12/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import MapKit

class Search: NSURLConnection {
    
    private let ClientID = "OLXCMXPWEIJ4JXBCWMD5JIPMXQGX02S15LHZHIHZMRIXCFG2"
    private let ClientSecret = "0CBC51OH2ZVGSZYWYDJ5WSUWLLSIH5AHRDZUNYJRBCCTZNKN"
    
    var lat:String!
    var long:String!
    
    // TODO: Create search methods
    
    func searchLocation(location: CLLocation) {
        lat = String(stringInterpolationSegment: location.coordinate.latitude)
        long = String(stringInterpolationSegment: location.coordinate.longitude)
        println("Latitude: \(lat), Longitude: \(long)")
        search()
    }
    
    private func search() {
        var searchUrl = NSURL(string: "http://api.foursquare.com/v2/venues/search?client_id=\(ClientID)&client_secret=\(ClientSecret)&ll=\(lat!),\(long!)&radius=16093&query=coffee&openNow=1&v=20150501&m=foursquare")
//        println("Search URL: \(searchUrl)")
        let session = NSURLSession.sharedSession()
        let sessionTask = session.dataTaskWithURL(searchUrl!, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                if let responseError = error {
                    println("Error: \(error)")
                    //            } else if let httpRsponse = response as? NSHTTPURLResponse {
                    //                println("HTTP Response: \(httpRsponse)")
                } else {
                    self.jsonFromData(data)
                }
        })
        sessionTask.resume()
    }
    
    private func jsonFromData(data: NSData) {
        var jsonError: NSError?
        let jsonData: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        
        parseJSON(jsonData)
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

//            println("ID: \(venueID) Name: \(venueName) Lat: \(lat.description) Lng: \(lng.description) ")
            
            // Create istance of CoffeeShop
            let shop = CoffeeShop(id: venueID, location: CLLocation(latitude: lat, longitude: lng), title: venueName)
            // Append to parsed array
            parsedVenues.append(shop)
        }
        
        for shop in parsedVenues {
            println("Shop: \(shop.title)")
        }
        // TODO: send to map to add pins
    }
}
