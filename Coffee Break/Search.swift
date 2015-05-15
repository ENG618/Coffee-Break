//
//  Search.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/12/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation

class Search {
    
    private let ClientID = "OLXCMXPWEIJ4JXBCWMD5JIPMXQGX02S15LHZHIHZMRIXCFG2"
    private let ClientSecret = "0CBC51OH2ZVGSZYWYDJ5WSUWLLSIH5AHRDZUNYJRBCCTZNKN"
    
    var lat:String!
    var long:String!
    
    // TODO: Create search methods
    
    private func search() {
        var searchUrl = NSURL(string: "http://api.foursquare.com/v2/venues/search?client_id=\(ClientID)&client_secret=\(ClientSecret)&ll=\(lat!),\(long!)&radius=16093&query=coffee&openNow=1")
        
        
    }
}
