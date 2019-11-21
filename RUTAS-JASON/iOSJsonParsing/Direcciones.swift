//
//  Direcciones.swift
//  iOSJsonParsing
//
//  Created by Fernando Vargas Salas on 11/20/19.
//  Copyright © 2019 JournalDev. All rights reserved.
//
import Foundation
import MapKit
import Contacts

class Direccion: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    let image: String
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D,image: String) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        self.image = image
        super.init()
    }
    
    init?(json: [Any]) {
        // 1
        if let title = json[1] as? String {
            self.title = title
        } else {
            self.title = "No Title"
        }
        // json[11] is the long description
        self.locationName = json[2] as! String
        self.image = json[5] as! String
        if let latitude = json[3] as? Double,
            let longitude = json[4] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var imageName: String? {
        if title == "Anexo de Ingenieria" { return "Anexo" }
        if title == "Facultad de Medicina" {return "Medicina" }
        if title == "Espacio Escultorico" {return "Espacio"}
        if title == "Facultad de Psicologia" {return "Psicologia"}
        if title == "Alberca Olímpica Universitaria" {return "Alberca"}
        if title == "Facultad de Arquitectura" {return "Arquitectura"}
        if title == "Rectoria UNAM" {return "Rectoria"}
        if title == "Facultad de Derecho"{return "Derecho"}
        if title == "Facultad de Filosofia" {return "Filosofia"}
        if title == "Estadio Olimpico Universitario" {return "Estadio" }
        if title == "Tapatio" {return "Tapatio"}
        if title == "Metro Universidad" {return "Metro"}
        if title == "Facultad de Odontología"{return "Facultad de Odontología"}
        if title == "Facultad de Contaduría y Administración" {return "Facultad de Contaduría y Administración"}
        if title == "Campo Beisbol Cu"{return "Campo Beisbol Cu"}
        if title == "Jardin Botánico"{return "Jardin Botánico"}
        if title == "Museo Universitario de Arte Contemporáneo"{return "Museo Universitario de Arte Contemporáneo" }
        if title == "Universum Museo de las Ciencias"{return "Universum Museo de las Ciencias"}
        if title == "Instituto de Investigaciones Históricas"{return "Instituto de Investigaciones Históricas" }
        if title == "Tienda Unam"{return "Tienda Unam"}
        return "Flag"
    }
    
}






