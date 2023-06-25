//
//  MapViewController.swift
//  Navigation
//
//  Created by M M on 6/9/23.
//

import Foundation
import UIKit
import SnapKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {

    // MARK: - Values
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocationCoordinate2D?


    //since prev change
    private lazy var longPressGR: UILongPressGestureRecognizer = {
        let longPress = UILongPressGestureRecognizer()
        longPress.minimumPressDuration = 0.3
        longPress.numberOfTapsRequired = 0 //
        longPress.addTarget(self, action: #selector(longPressAction))
        return longPress
    } ()

    var directionsArray: [MKDirections] = []
    

    // MARK: - View Elements
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isRotateEnabled = false
        mapView.mapType = .standard
        mapView.addGestureRecognizer(longPressGR)
        mapView.delegate = self
        return mapView
    }()

    // MARK: - init

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        /*locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()*/
        checkLocationAutorization()
    }

    private func setupView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    private func checkLocationAutorization() {

        switch locationManager.authorizationStatus {

        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            debugPrint("Restricted")
            //break
        case .denied:
            // Show alert instructing them how to turn on permissions
            debugPrint("Denied")
            //break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError()
        }
    }

    func addPin(_ coordinate: CLLocationCoordinate2D, description: String = "destination") {
        removePreviousPins()

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        if description == "destination" {
            previousLocation = coordinate
        }
        mapView.addAnnotation(pin)
    }

    func removePreviousPins() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
    }

    func showRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {

        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinatinPlacemark = MKPlacemark(coordinate: destination)

        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinatinPlacemark)

        let request = MKDirections.Request()
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = .automobile
        request.requestsAlternateRoutes = true

        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let error = error {
                    print("error | directions.calculate | \(error.localizedDescription)")
                }
                return
            }

            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline)
            self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
        }
    }

    // MARK: - @objc Methods
    @objc func longPressAction(_ sender: UILongPressGestureRecognizer) {
        let destinationCoordinate = self.mapView.convert(sender.location(in: mapView), toCoordinateFrom: self.mapView)

        guard let location = locationManager.location?.coordinate else {
            //TODO: Inform user we don't have their current location
            return
        }

        addPin(destinationCoordinate)
        showRoute(from: location, to: destinationCoordinate)
    }

    // MARK: - Observers

}

// MARK: - Extensions
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters  )
        mapView.setRegion(region, animated: true)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAutorization()
        }
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        mapView.removeOverlays(mapView.overlays)
        guard let location = locationManager.location?.coordinate else { return }
        let destination = annotation.coordinate
        addPin(destination)
        showRoute(from: location, to: destination)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 5
        return renderer
    }
}
