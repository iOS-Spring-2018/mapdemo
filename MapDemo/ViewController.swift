//
//  ViewController.swift
//  MapDemo
//
//  Created by Jon Eikholm on 19/02/2018.
//  Copyright © 2018 Jon Eikholm. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // same as Java's this
        locationManager.requestWhenInUseAuthorization()  // goes together with the .plist entry
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            print("new position received \(loc)")
            let region = MKCoordinateRegionMakeWithDistance(loc.coordinate, 400, 400)
            map.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse: print("location access granted")
        default: print("access denied")
        }
    }
    
    @IBAction func satBtnPressed(_ sender: UIButton) {
        map.mapType = MKMapType.satellite
    }
    
}

