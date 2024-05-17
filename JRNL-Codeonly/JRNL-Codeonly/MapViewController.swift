//
//  MapViewController.swift
//  JRNL-Codeonly
//
//  Created by 차지용 on 5/13/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate { //MKMapViewDelegate지도에 주석달기
    let locationManager = CLLocationManager() //위치정보를 가져오기 위해서 CoreLocation을 class내부에 선언
    var selectedJournalEntry: JournalEntry?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Map"
        view.addSubview(mapView)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //위치 가져오기
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer //위치정확도 설정
        mapView.delegate = self
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        locationManager.requestLocation()//현재 위치정보 요청
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.first {
            let lat = myLocation.coordinate.latitude
            let long =  myLocation.coordinate.longitude
            self.navigationItem.title = "Map"
            mapView.region = setInitialRegion(lat: lat, long: long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to fond user's location: \(error.localizedDescription)")
    }
    
    //지도에 표시하는 커스텀뷰를 제공함
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapAnnotation"
        if annotation is JournalEntry {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){ //dequeueReusableAnnotationView이 맵에서 사용되는 주석을 재사용이 가능하게해줌
                annotationView.annotation = annotation
                return annotationView
            }
            else {
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let calloutButton = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = calloutButton
                return annotationView
            }
        }
        return nil
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else {
            return
        }
        selectedJournalEntry = annotation as? JournalEntry
        self.performSegue(withIdentifier: "showMapDetail", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(fore)
    
    
    
    // MARK: - Methods
    func setInitialRegion(lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
