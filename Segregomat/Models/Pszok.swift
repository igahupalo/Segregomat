//
//  Checkpoint.swift
//  Segregomat
//
//  Created by Iga Hupalo on 01/07/2020.
//  Copyright © 2020 Iga Hupalo. All rights reserved.
//

import Foundation
import MapKit
import FirebaseDatabase


final class Pszok: NSObject, MKAnnotation, Identifiable {
    let key: String
    let id: String
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let latitude: Double
    let longitude: Double
    let address: String
    let ref: DatabaseReference?
  
//  init(title: String?, coordinate: CLLocationCoordinate2D) {
//    self.title = title
//    self.coordinate = coordinate
//  }
    
    
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let title = value["name"]  as AnyObject? as? String,
            let latitude = value["latitude"] as AnyObject? as? Double,
            let longitude = value["longitude"] as AnyObject? as? Double,
            let address = value["address"]  as AnyObject? as? String
        else {
            return nil
        }
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.id = snapshot.key
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        self.address = address
        self.subtitle = address
    }
    
    public override var description: String {
        return "Name: \(title)\nlatitude: \(latitude)\nlongitude: \(longitude)\ncoordinate: \(coordinate)\n"
    }
}
