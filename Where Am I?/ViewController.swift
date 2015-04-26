//
//  ViewController.swift
//  Where Am I?
//
//  Created by Paul Corpuz on 4/26/15.
//  Copyright (c) 2015 coppermind. All rights reserved.
//

import UIKit;
import CoreLocation;

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!;
    
    @IBOutlet var latValue: UILabel!;
    @IBOutlet var longValue: UILabel!;
    @IBOutlet var courseValue: UILabel!;
    @IBOutlet var speedValue: UILabel!;
    @IBOutlet var altValue: UILabel!;
    @IBOutlet var nearestAddress: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        initLocationManager();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location = manager.location;
        
        latValue.text = "\(location.coordinate.latitude)";
        longValue.text = "\(location.coordinate.longitude)";
        courseValue.text = "\(location.course)";
        speedValue.text = "\(location.speed)";
        altValue.text = "\(location.altitude)";

        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placeMarks, error) -> Void in
            if (error != nil) {
                println("Reverse GeoCoder failed with error \(error.localizedDescription)");
            }
            
            if (placeMarks == nil) {
                println("Data error from GeoCoder");
                //var pm = placeMarks[0] as! CLPlacemark;
                //println(pm);
            } else {
                var pm = placeMarks[0] as! CLPlacemark;
                self.displaceLocationInfo(pm);
            }
        })
    }
    
    func displaceLocationInfo(placeMark: CLPlacemark) {
        nearestAddress.text = "\(placeMark.locality)\n\(placeMark.postalCode)\n\(placeMark.administrativeArea)\n\(placeMark.country)";
    }
    
}

