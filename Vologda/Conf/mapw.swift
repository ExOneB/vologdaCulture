//
//  mapw.swift
//  Vologda
//
//  Created by Maxim Pyatovskiy on 27/04/2019.
//  Copyright © 2019 Maxim Pyatovskiy. All rights reserved.
//

import MapKit

class mapw: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}

