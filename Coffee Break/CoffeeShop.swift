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
    
    var id: String
    var location: CLLocation
    var title: String
    
    required init(id: String, location: CLLocation, title: String) {
        self.id = id
        self.location = location
        self.title = title
    }
}
