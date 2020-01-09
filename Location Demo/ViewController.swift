//
//  ViewController.swift
//  Location Demo
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //create a variable for CLLocationManager
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //grabbing the user location
        let userLocation: CLLocation = locations[0]
        
        let lat = userLocation.coordinate.latitude
        let long = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
      
        //print(userLocation)
        
        //finding the user address from the user laoction
        
        CLGeocoder().reverseGeocodeLocation(userLocation){
            (Placemarks,error) in
            if let error = error {
                print(error)
            }else {
                if let placemark = Placemarks?[0]{
                    var subthoroughfare = ""
                    if placemark.subThoroughfare != nil {
                        subthoroughfare = placemark.subThoroughfare!
                    }
                    var thoroufare = ""
                    if placemark.thoroughfare != nil {
                        thoroufare = placemark.thoroughfare!
                    }
                    var subLocalit = ""
                    if placemark.subLocality != nil{
                        subLocalit = placemark.subLocality!
                    }
                    var subAdministrativeArea = ""
                    if placemark.subAdministrativeArea != nil{
                        subAdministrativeArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil{
                        postalCode = placemark.postalCode!
                    }
                    var country = ""
                    if placemark.country != nil{
                        country = placemark.country!
                    }
                    
                    print(subthoroughfare + "\n" + thoroufare + "\n" + subLocalit + "\n" + subAdministrativeArea +  "\n" + postalCode + "\n" +  country)
                }
            }
        }
        
    }

}

