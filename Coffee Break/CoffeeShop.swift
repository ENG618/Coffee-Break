//
//  CoffeeShop.swift
//  Coffee Break
//
//  Created by Eric Garcia on 5/15/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import MapKit

class CoffeeShop: NSObject, MKAnnotation {
    
    var id: String
    var title: String
    var coordinate: CLLocationCoordinate2D
    
    init(id: String, title: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String {
        return title
    }
}
