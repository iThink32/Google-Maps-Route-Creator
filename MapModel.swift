//
//  MapModel.swift
//  Rynly
//
//  Created by N A Shashank on 12/28/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import CoreLocation

class MapModel {
    
    var sourceLocation = CLLocationCoordinate2D()
    var destinationLocation = CLLocationCoordinate2D()
    var waypoints = [CLLocationCoordinate2D]()
    var zoom = Float(0)
    var course = CLLocationDirection()
    
    init?(sourceLocation:CLLocationCoordinate2D,destination:CLLocationCoordinate2D,waypoints:[CLLocationCoordinate2D]?,zoom:Float)
    {
        guard isDataValid(sourceLocation:sourceLocation,destinationLocation:destination,wayPoints:waypoints) else{
            return nil
        }
        self.sourceLocation = sourceLocation
        self.destinationLocation = destination
        if let unwrappedWaypoints = waypoints
        {
            self.waypoints = unwrappedWaypoints
        }
        self.zoom = zoom
    }
    
    private func isDataValid(sourceLocation:CLLocationCoordinate2D,destinationLocation:CLLocationCoordinate2D,wayPoints:[CLLocationCoordinate2D]?) -> Bool
    {
        let validSource = sourceLocation.latitude != 0.0 && sourceLocation.longitude != 0.0
        let validDestination = destinationLocation.latitude != 0.0 && destinationLocation.longitude != 0.0
        var validWaypoints =  true
        if let unwrappedWaypoints = wayPoints
        {
            validWaypoints = unwrappedWaypoints.count > 0
        }
        return validSource && validDestination && validWaypoints
    }
    
}
