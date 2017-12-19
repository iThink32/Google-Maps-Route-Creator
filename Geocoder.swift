//
//  GeoCoder.swift
//  AuthDemo
//
//  Created by N A Shashank on 12/5/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import CoreLocation

class GeoCoder
{  
   //APPLE PROVIDED GEOCODER
   class func locationFromString(str:String,callBack:@escaping (CLLocationCoordinate2D) -> Void,failureCallBack:@escaping ()->Void)
    {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(str) { (arrPlacemarks, error) in
            guard let unwrappedPlacemarks = arrPlacemarks ,let placemark = unwrappedPlacemarks.first, error == nil else{
                failureCallBack()
                return
            }
            
            guard let location = placemark.location else{
                failureCallBack()
                return
            }
            callBack(location.coordinate)
        }
    }
    //GOOGLE PROVIDED GEOCODER
    class func geocodeAddress(address:String,successCallBack:@escaping (CLLocationCoordinate2D) -> Void,failureCallBack:@escaping ()->Void)
    {
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics) else{
            return
        }
        let strUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=\(encodedAddress)&key=ADD_UR_API_KEY_HERE"
        guard let url = URL(string:strUrl) else{
            return
        }
        URLSession.shared.dataTask(with: url) { (data, url, error) in
            guard let unwrappedData = data ,let jsonReceived = try? JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) ,let dictReceived = jsonReceived as? [String:Any] else{
                failureCallBack()
                return
            }
            guard let arrResults = dictReceived["results"] as? [[String:Any]],arrResults.count > 0, let dictGeometry = arrResults[0]["geometry"] as? [String:Any] , let dictLocation = dictGeometry["location"] as? [String:Any] , let lat = dictLocation["lat"] as? Double , let long = dictLocation["lng"] as? Double else{
                failureCallBack()
                return
            }
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            successCallBack(coordinate)
        }.resume()
    }
}
