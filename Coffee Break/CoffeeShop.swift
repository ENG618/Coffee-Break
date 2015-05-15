//
//  CoffeeShop.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/15/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import MapKit

class CoffeeShop {
    
    var location: CLLocation
    var title: String
    var description: String
    
    required init(location: CLLocation, title: String, description: String) {
        self.location = location
        self.title = title
        self.description = description
    }
}
