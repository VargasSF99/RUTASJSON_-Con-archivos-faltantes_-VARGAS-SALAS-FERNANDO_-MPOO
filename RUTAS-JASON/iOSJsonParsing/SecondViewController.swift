//
//  SecondViewController.swift
//  iOSJsonParsing
//
//  Created by Fernando Vargas Salas on 11/13/19.
//  Copyright © 2019 JournalDev. All rights reserved.
//

import UIKit
import MapKit
import AddressBook
import Contacts

class SecondViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    var todo = [Direccion]()
    
    
    let locainicial = CLLocation(latitude: 19.325650, longitude: -99.182078)
    
    @IBOutlet weak var INSTRUCCIONES: UILabel!
   
 @IBOutlet weak var selector: UISegmentedControl!
    
    @IBOutlet weak var mapa: MKMapView!
    @IBAction func INICIO(sender: Any){
        zoom(location: locainicial)
        self.mapa.removeOverlays(self.mapa.overlays)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoom(location: locainicial)
        mapa.delegate = self
        loadInitialData()
        mapa.addAnnotations(todo)
       INSTRUCCIONES.text = "1.Da CLICK sobre el PIN/TRAZAR RUTA"
        //INSTRUCCIONES2.text = "2. Presiona TRAZAR RUTA"
        
        mapa.register(ArtworkView.self,
                      forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
    }
    
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "Lugares", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let direcciones = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = direcciones.compactMap { Direccion(json: $0) }
        todo.append(contentsOf: validWorks)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocation()
    }
    
    private let region: CLLocationDistance = 1500
    func zoom(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance (location.coordinate,region * 2.0, region * 2.0)
        mapa.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if  let location = view.annotation as? Direccion{
            self.currentPlacemark = MKPlacemark(coordinate: location.coordinate)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let linea = MKPolylineRenderer(overlay: overlay)
        linea.strokeColor = UIColor.black
        linea.lineWidth = 6.0
        
        return linea
    }
    
    // MARK: - CURRENT LOCATION
    
    var locationManager = CLLocationManager()
    func checkLocation (){
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapa.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    var currentPlacemark: CLPlacemark?
    @IBAction func showDirecciones(sender: Any){
        guard  let  currentPlacemark = currentPlacemark else {
            return
        }
        let directionRequest = MKDirections.Request()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .walking
        
        
        //CALCULAR RUTAS
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {(directionsResponse,error ) in
            guard directionsResponse != nil else {
                if error != nil{
                    print ("Error , no hay direcciones")
                }
                return
            }
            let ruta = directionsResponse!.routes[0]
            self.mapa.removeOverlays(self.mapa.overlays)
            self.mapa.add(ruta.polyline,level: .aboveRoads)
            
            let rutazoom = ruta.polyline.boundingMapRect
            self.mapa.setRegion(MKCoordinateRegionForMapRect(rutazoom), animated: true)
            
        }
    }
    @IBAction func cambiarVista(_ sender: Any) {
        
        switch selector.selectedSegmentIndex {
        case 0:
            mapa.mapType = .standard
            
        case 1:
            mapa.mapType = .satellite
            
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        self.mapa.showsUserLocation = true
        zoom(location: location)
    }
    
  
    
    
    
    
    
}






