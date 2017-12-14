//
//  RouteCreater.swift
//  TestGoogleMaps
//
//  Created by N A Shashank on 12/14/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteCreater {
    
    class func navigationPath(dictPathInformation:[String:Any]) -> GMSPath?
    {
        guard let arrRoutes = dictPathInformation["routes"] as? [[String:Any]],arrRoutes.count > 0,let arrLegs = arrRoutes[0]["legs"] as? [[String:Any]],let arrSteps = arrLegs[0]["steps"] as? [[String:Any]]  else{
            return nil
        }
        var stepIndex = 0
        let path = GMSMutablePath()
        for step in arrSteps
        {
            guard let dictStartLocation = step["start_location"] as? [String:Any] else{
                return nil
            }
            stepIndex = stepIndex + 1
            guard let coordinate = RouteCreater.coordinateFromLocation(dict:dictStartLocation) else{
                return nil
            }
            path.add(coordinate)
            guard let dictPolyLine = step["polyline"] as? [String:Any],let polyLinePoints = dictPolyLine["points"] as? String else{
                return nil
            }
            let polyLinePath = GMSPath(fromEncodedPath: polyLinePoints)
            guard let unwrappedPolyLinePath = polyLinePath else{
                return nil
            }
            for index in 0..<unwrappedPolyLinePath.count()
            {
                path.add(unwrappedPolyLinePath.coordinate(at: index))
            }
            if arrSteps.count == stepIndex
            {
                guard let dictEndLocation = step["end_location"] as? [String:Any] else{
                    return nil
                }
                stepIndex = stepIndex + 1
                guard let coordinate = RouteCreater.coordinateFromLocation(dict:dictEndLocation) else{
                    return nil
                }
                path.add(coordinate)
            }
        }
        return path
    }
    
    
    class func fetchRouteInformation(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D,successCallBack:@escaping ([String:Any]) -> Void,failureCallBack:@escaping Typealias.MapCallBack)
    {
        let origin = "\(from.latitude),\(from.longitude)"
        let dest = "\(to.latitude),\(to.longitude)"
        let strURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(dest)&mode=driving&key=\(ENTER_YOUR_API_KEY_HERE)"
        guard let url = URL(string: strURL) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, url, error) in
            guard let unwrappedData = data ,let jsonReceived = try? JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) ,let dictReceived = jsonReceived as? [String:Any] else{
                failureCallBack(MapError.pathFetchFailed)
                return
            }
            successCallBack(dictReceived)
            }.resume()
    }
    
    private class func coordinateFromLocation(dict:[String:Any]) -> CLLocationCoordinate2D?
    {
        guard let lat = dict["lat"] as? Double,let long = dict["lng"] as? Double else{
            return nil
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}
