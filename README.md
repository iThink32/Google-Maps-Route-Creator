# Google-Maps-Route-Creator
A Class that creates a GMSPath that can be used to construct a path between A and B

Usage:-

```

self.fetchRouteInformation(from: unwrappedModel.sourceLocation, to: unwrappedModel.destinationLocation,successCallBack: { [weak self](dictReceived) in
            
            guard let unwrappedSelf = self, let unwrappedPath = unwrappedSelf.navigationPath(dictPathInformation: dictReceived) else{
                callBack(MapError.pathDrawFailed)
                return
            }
            DispatchQueue.main.async {
                unwrappedSelf.currentPolyline = GMSPolyline(path: unwrappedPath)
                unwrappedSelf.currentPolyline?.strokeWidth = 2.0
                unwrappedSelf.currentPolyline?.strokeColor = UIColor.orange
                unwrappedSelf.currentPolyline?.map = unwrappedSelf.mapView
                callBack(nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    let mapModel = MapModel(sourceLocation: CLLocationCoordinate2D(latitude: 12.907753, longitude: 77.521004), destination: CLLocationCoordinate2D(latitude: 13.346171, longitude: 74.764600), zoom: 16.0)
                    
                   unwrappedSelf.updateMap(mapModel: mapModel, callBack: { (error) in
                       //callBack(nil)
                       print(error)
                    })
                }
            }
            },failureCallBack: {(error) -> Void in
                callBack(error)
        })
        
```
