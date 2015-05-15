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
        println("Search URL: \(searchUrl)")
        let session = NSURLSession.sharedSession()
//        let sessionTask = session.dataTaskWithURL(searchUrl!)
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
        let response = jsonData["response"] as! NSDictionary
        let venues = response["venues"] as! [NSDictionary]
        
        for venue in venues {
            
            let name = venue["name"] as! String
            
            
            println("Name: \(name)")
        }
    }
}
