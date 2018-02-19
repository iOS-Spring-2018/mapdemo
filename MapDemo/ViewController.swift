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

    @IBOutlet weak var streetInput: UITextField!
    
    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // same as Java's this
        locationManager.requestWhenInUseAuthorization()  // goes together with the .plist entry
        //locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func centerMapTo(_ loc: CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(loc.coordinate, 400, 400)
        map.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            print("new position received \(loc)")
            centerMapTo(loc)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse: print("location access granted")
        default: print("access denied")
        }
    }
    @IBAction func searcBtnPressed(_ sender: Any) {
        let geoCoder = CLGeocoder()
        print("you search...")
        if let streetAdr = streetInput.text{
            geoCoder.geocodeAddressString(streetAdr){(placemark, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                if let pm = placemark, let loc2 = pm.first {
                    print("result: \(loc2)")
                    DispatchQueue.main.async {
                        self.centerMapTo(loc2.location!)
                    }
                }
                
               
            }
        }
    }
    
    @IBAction func satBtnPressed(_ sender: UIButton) {
        map.mapType = MKMapType.satellite
    }
    
}

















