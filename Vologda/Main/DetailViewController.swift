//
//  DetailViewController.swift
//  Vologda
//
//  Created by Maxim Pyatovskiy on 26/04/2019.
//  Copyright © 2019 Maxim Pyatovskiy. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var id: Int = 0
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let latitude = Double(cultureArray[id].latitude)
        let longitude = Double(cultureArray[id].longitude)
        
        let initialLocation = CLLocation(latitude: latitude!, longitude: longitude!)

        
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        centerMapOnLocation(location: initialLocation)
        
        let Mapw = mapw(title: cultureArray[id].name,
                              locationName: cultureArray[id].adress,
                              discipline: cultureArray[id].type,
                              coordinate: CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!))
        mapView.addAnnotation(Mapw)
        
        title = cultureArray[id].name
        name.text = cultureArray[id].name
        area.text = cultureArray[id].area
        adress.text = cultureArray[id].adress
    }

    
}
