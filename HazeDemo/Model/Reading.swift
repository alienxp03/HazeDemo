//
//  Reading.swift
//  HazeDemo
//
//  Created by Muhammad Azuan Zira Zairein on 16/01/2016.
//  Copyright © 2016 Muhammad Azuan Zira Zairein. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

struct Reading {
    let reading         : String
    let location        : Location
    
    init(json: JSON) {
        reading = json["terkini"].stringValue
        location = Location(json: json["location"])
    }
}

struct Location {
    let name            : String
    let state           : String
    let coordinate      : CLLocationCoordinate2D
    
    init(json: JSON) {
        state = json["state"].stringValue
        name = json["area"].stringValue
        coordinate = CLLocationCoordinate2D(
            latitude: json["coordinates"]["latitude"].doubleValue,
            longitude: json["coordinates"]["longitude"].doubleValue)
    }
}
