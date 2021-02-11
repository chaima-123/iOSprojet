//
//  MapViewController.swift
//  MiniProjet
//
//  Created by mac  on 04/12/2020.
//

import UIKit
import MapKit
import  CoreLocation

class MapViewController: UIViewController  {


    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
   
    let locationManager = CLLocationManager()
        let regionInMeters: Double = 10000
    

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()

        
        btn.layer.masksToBounds = true

        btn.applyGradient(colours: [.purple, .systemPurple])

        btn.layer.cornerRadius = 20
        
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    @IBAction func btn(_ sender: Any)
    {
        let userLocation = mapView.userLocation

                   //guard let location = locations.last else { return }
                   var longitute: CLLocationDegrees = (locationManager.location?.coordinate.longitude) as! CLLocationDegrees
                   var latitude: CLLocationDegrees = (locationManager.location?.coordinate.latitude) as! CLLocationDegrees
                   var location = CLLocation(latitude: latitude, longitude: longitute)
                   CLGeocoder().reverseGeocodeLocation( location, completionHandler: {(placemarks, error) -> Void in

                       if (error != nil ){

                           print("failed")

                           return
                       }

                       if ((placemarks?.count)! > 0)
                       {

                           let pm = placemarks?[0] as! CLPlacemark?

                           let sub = (pm?.subThoroughfare)

                           let Tho = (pm?.thoroughfare)!

                           let loc = (pm?.locality)!

                           let ad = (pm?.administrativeArea)!

                           let pc = (pm?.postalCode)

                           let isc = (pm?.isoCountryCode)!

                      let address =  loc + " " + ad + ", " + Tho + isc
                        UserDefaults.standard.set(ad, forKey: "adress")
                        print(UserDefaults.standard.string(forKey: "adress")!)
                        print(address)

                       // print(error)
                       }

                       else {
                           print("error")
                       }
                   })
        
        
        
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
         
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
}




extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

