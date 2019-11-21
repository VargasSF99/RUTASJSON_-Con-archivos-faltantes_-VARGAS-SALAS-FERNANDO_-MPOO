//
//  Pins.swift
//  iOSJsonParsing
//
//  Created by Fernando Vargas Salas on 11/20/19.
//  Copyright © 2019 JournalDev. All rights reserved.
//

import Foundation
import Foundation
import MapKit

class Pins: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let pin = newValue as? Direccion else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = pin.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
        }
    }
    
}

class ArtworkView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let pin = newValue as? Direccion else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = pin.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = pin.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
    
}
