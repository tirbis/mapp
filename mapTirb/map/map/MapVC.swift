//
//  MapVC.swift
//  map
//
//  Created by Admin on 18.12.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let location = CLLocationManager()
    
    struct Points {
        var lat = 0.0
        var lon = 0.0
        var name = ""
    }
    var pointsArray = [Points]()
    override func viewDidLoad() {
        super.viewDidLoad()
        location.delegate = self
        mapView.delegate = self
        
        location.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        mapView.userLocation.title = "Im here"
        mapView.userLocation.subtitle = "You found me"
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.coordinate.latitude != mapView.userLocation.coordinate.latitude && annotation.coordinate.longitude != mapView.userLocation.coordinate.longitude {
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
            
            marker.canShowCallout = true
            let infoButton = UIButton(type: .detailDisclosure)
            infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
            marker.rightCalloutAccessoryView = infoButton
            marker.calloutOffset = CGPoint(x: -5, y: 5)
            return marker
        }
        return nil
    }
    @objc func infoAction(){
        print("Info")
    }
    func mapToCoordinate(coordinate: CLLocationCoordinate2D){
        let region = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            mapToCoordinate(coordinate: location)
        }
    }
    func pointsPositisionalCollege(){
        let arrayLat = [55.818176, 55.844996, 55.860595, 55.860337]
        let arrayLon = [37.496261, 37.520960, 37.492089, 37.517689]
        let arrayName = ["ЦИКТ", "ЦПиРБ", "ЦАВТ", "ЦТЭК"]
        
        for number in 0..<arrayLat.count {
            pointsArray.append(Points(lat: arrayLat[number], lon: arrayLon[number], name: arrayName[number]))
        }
    }
    func pointsPositions(){
        for number in 0..<pointsArray.count {
            let point = MKPointAnnotation()
            point.title = pointsArray[number].name
            point.coordinate = CLLocationCoordinate2D(latitude: pointsArray[number].lat, longitude: pointsArray[number].lon)
            mapView.addAnnotation(point)
        }
    }
}
