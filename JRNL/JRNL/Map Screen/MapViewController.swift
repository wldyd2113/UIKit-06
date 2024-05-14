//
//  MapViewController.swift
//  JRNL
//
//  Created by 차지용 on 5/14/24.
//

import UIKit
import CoreLocation
import MapKit
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    let locationManger = CLLocationManager()
    var sampleJournalEntryData = SampleJournalEntryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        self.navigationItem.title = "Loading..."
        locationManger.requestLocation()
        mapView.delegate = self
        sampleJournalEntryData.createSampleJournalEntryData()
        mapView.addAnnotation(sampleJournalEntryData.journalEntries)
        
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.first {
            let lat = myLocation.coordinate.latitude
            let long = myLocation.coordinate.longitude
            self.navigationItem.title = "Map"
            mapView.region = setInitialRegion(lat: lat, long: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    // MARK: - Methods
    func setInitialRegion(lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
    }

}
