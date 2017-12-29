//
//  Utilities.swift
//  Rynly
//
//  Created by N A Shashank on 12/21/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import CoreLocation

final class Utilities {

    class func logoHeight(viewFrame:CGRect) -> CGFloat {
        let imgAspectRatio = 280.0 / 160.0
        let imgWidth = viewFrame.width - 60
        return imgWidth * CGFloat(1.0/imgAspectRatio)
    }
    
    class func modelFromUserStringsFor(strSourceLocation:String,strDestination:String,waypoints:[String]?,successCallBack:@escaping (MapModel)-> Void,failureCallBack:@escaping ()-> Void) {
        var sourceLocation = CLLocationCoordinate2D()
        var destinationLocation = CLLocationCoordinate2D()
        var wayPoints = [CLLocationCoordinate2D]()
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Geocoder.googleGeocodedAddress(address: strSourceLocation, successCallBack: { (location) in
            sourceLocation = location
            dispatchGroup.leave()
        }, failureCallBack: {
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Geocoder.googleGeocodedAddress(address: strDestination, successCallBack: { (location) in
            destinationLocation = location
            dispatchGroup.leave()
        }, failureCallBack: {
            dispatchGroup.leave()
        })
        
        guard let unwrappedWaypoints = waypoints else{
            return
        }
        for waypoint in unwrappedWaypoints
        {
            dispatchGroup.enter()
            Geocoder.googleGeocodedAddress(address: waypoint, successCallBack: { (location) in
                wayPoints.append(location)
                dispatchGroup.leave()
            }, failureCallBack: {
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            guard let mapModel = MapModel(sourceLocation: sourceLocation, destination: destinationLocation, waypoints: wayPoints, zoom: 16.0) else{
                return failureCallBack()
            }
            successCallBack(mapModel)
        }
    }
    
    class func encodeToData(value:PathInformationModel) {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(data, forKey: "path")
    }
    
    class func archiveMapModel(data:[String:Any]) {
        UserDefaults.standard.set(data, forKey: "navigationPath")
        UserDefaults.standard.synchronize()
    }
    
    class func unarchiveMapModel() -> [String:Any]? {
        guard let object = UserDefaults.standard.object(forKey: "navigationPath") as? [String:Any] else{
            return nil
        }
        return object
    }

}
