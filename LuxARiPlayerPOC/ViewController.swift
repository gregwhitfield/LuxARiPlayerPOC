//
//  ViewController.swift
//  LuxARiPlayerPOC
//
//  Created by Gregory Whitfield on 15/08/18.
//  Copyright © 2018 Gregory Whitfield. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        startLocation = nil
    }

    @IBAction func resetDistance(_ sender: Any) {
        startLocation = nil
    }
    
    @IBAction func startWhenInUse(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func startAlways(_ sender: Any) {
        locationManager.stopUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager:CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        latitude.text = String(format: "%.4f", latestLocation.coordinate.latitude)
        longitude.text = String(format: "%.4f", latestLocation.coordinate.longitude)
        hAccuracy.text = String(format: "%.4f", latestLocation.horizontalAccuracy)
        altitude.text = String(format: "%.4f", latestLocation.altitude)
        vAccuracy.text = String(format: "%.4f", latestLocation.verticalAccuracy)
        
        if startLocation == nil {
            startLocation = latestLocation
        }
        
        let distanceBetween: CLLocationDistance = latestLocation.distance(from: startLocation)
        distance.text = String(format: "%.2f", distanceBetween)
        
        print("Latitude \(latestLocation.coordinate.latitude)")
        print("Longitude = \(latestLocation.coordinate.longitude)")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

}

