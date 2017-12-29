//
//  MapManager.swift
//  TestGoogleMaps
//
//  Created by N A Shashank on 12/8/17.
//  Copyright © 2017 N A Shashank. All rights reserved.
//

import UIKit
import GoogleMaps

final class MapManager {
    
    private var mapModel:MapModel?
    var error:MapError?
    var currentPolyline:GMSPolyline?
    var marker:GMSMarker?
    var mapView:GMSMapView?
    
    func setupMap(mapModel:MapModel,callBack:@escaping (GMSMapView?,MapError?) -> Void)
    {
        let cameraPosition = GMSCameraPosition.camera(withLatitude:mapModel.sourceLocation.latitude, longitude:  mapModel.sourceLocation.longitude, zoom: mapModel.zoom)
        self.mapModel = mapModel
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cameraPosition)
        guard let unwrappedMapView = self.mapView else{
            callBack(nil,nil)
            return
        }
        unwrappedMapView.accessibilityElementsHidden = false
        unwrappedMapView.isMyLocationEnabled = true
        unwrappedMapView.settings.myLocationButton = true
        unwrappedMapView.settings.compassButton = true
        self.drawPath { (error) in
            guard let _ = error else{
                callBack(unwrappedMapView,nil)
                return
            }
            callBack(nil,nil)
        }
    }
    
    func bypass(callBack:@escaping (GMSMapView?,MapError?) -> Void)
    {
        let cameraPosition = GMSCameraPosition.camera(withLatitude:45.5353847, longitude: -122.6383647, zoom: 16)
//        self.mapModel = mapModel
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: cameraPosition)
        guard let unwrappedMapView = self.mapView else{
            callBack(nil,nil)
            return
        }
        unwrappedMapView.accessibilityElementsHidden = false
        unwrappedMapView.isMyLocationEnabled = true
        unwrappedMapView.settings.myLocationButton = true
        unwrappedMapView.settings.compassButton = true

        guard let dictReceived = Utilities.unarchiveMapModel(), let unwrappedPath = RouteCreater.navigationPath(dictPathInformation: dictReceived) else{
//            callBack(MapError.pathDrawFailed)
            return
        }
        DispatchQueue.main.async {
            self.currentPolyline = GMSPolyline(path:unwrappedPath.path)
            self.currentPolyline?.strokeWidth = 2.0
            self.currentPolyline?.strokeColor = UIColor.orange
            self.currentPolyline?.map = self.mapView
            self.plotMarkers(path: unwrappedPath)
            callBack(unwrappedMapView,nil)
        }
    }
    
    func resetMap()
    {
        self.currentPolyline?.map = nil
        self.marker?.map = nil
    }
    
    func updateMap(mapModel:MapModel,callBack:@escaping Typealias.MapCallBack)
    {
        //mysore - 12.2958° N, 76.6394° E
        //udupi - 13.3409° N, 74.7421° E
        self.resetMap()
        self.mapModel = mapModel
        self.drawPath(){(error) -> Void in
            callBack(error)
        }
    }
    
    private func drawPath(callBack:@escaping (_ error:MapError?) -> Void)
    {
        guard let unwrappedModel = self.mapModel else{
            callBack(MapError.dataSourceMissing)
            return
        }
        // reposition camera
        let cameraPosition = GMSCameraPosition.camera(withTarget: unwrappedModel.sourceLocation, zoom: 16.0)
        self.mapView?.animate(to: cameraPosition)
        RouteCreater.fetchRouteInformation(from: unwrappedModel.sourceLocation, to: unwrappedModel.destinationLocation,waypoints: unwrappedModel.waypoints,successCallBack: { [weak self](dictReceived) in
            Utilities.archiveMapModel(data: dictReceived)
            guard let unwrappedSelf = self, let unwrappedPath = RouteCreater.navigationPath(dictPathInformation: dictReceived) else{
                callBack(MapError.pathDrawFailed)
                return
            }
            DispatchQueue.main.async {
                unwrappedSelf.currentPolyline = GMSPolyline(path:unwrappedPath.path)
                unwrappedSelf.currentPolyline?.strokeWidth = 2.0
                unwrappedSelf.currentPolyline?.strokeColor = UIColor.orange
                unwrappedSelf.currentPolyline?.map = unwrappedSelf.mapView
                unwrappedSelf.plotMarkers(path: unwrappedPath)
                callBack(nil)
            }
            },failureCallBack: {(error) -> Void in
                callBack(error)
        })
    }
    
    func plotMarkers(path:PathInformationModel) {
        let legs = path.arrLegs
        for (index,leg) in zip(1..., legs)
        {
            guard let startLatitude = leg.startLocation["lat"] as? Double , let startLongitude = leg.startLocation["lng"] as? Double , let endLatitude = leg.endLocation["lat"] as? Double, let endLongitude = leg.endLocation["lng"] as? Double else{
                return
            }
            self.addMarker(location: CLLocationCoordinate2D(latitude: startLatitude, longitude: startLongitude), snippet: leg.startAddress)
            if index == legs.count
            {
                self.addMarker(location: CLLocationCoordinate2D(latitude: endLatitude, longitude: endLongitude), snippet: leg.endAddress)
            }
        }
    }
    
    func addMarker(location:CLLocationCoordinate2D,snippet:String) {
        let marker = GMSMarker()
        marker.position = location
        marker.snippet = snippet
        marker.map = self.mapView
    }
    
}
