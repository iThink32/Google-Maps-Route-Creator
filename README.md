# Google-Maps-Route-Creator
A Class that creates a GMSPath that can be used to construct a path between A and B

Usage:-

```

RouteCreater.fetchRouteInformation(from: unwrappedModel.sourceLocation, to: unwrappedModel.destinationLocation,successCallBack: { [weak self](dictReceived) in
            
            guard let unwrappedSelf = self, let unwrappedPath = RouteCreater.navigationPath(dictPathInformation: dictReceived) else{
                callBack(MapError.pathDrawFailed)
                return
            }
            DispatchQueue.main.async {
                unwrappedSelf.currentPolyline = GMSPolyline(path: unwrappedPath)
                unwrappedSelf.currentPolyline?.strokeWidth = 2.0
                unwrappedSelf.currentPolyline?.strokeColor = UIColor.orange
                unwrappedSelf.currentPolyline?.map = unwrappedSelf.mapView
                callBack(nil)
            }
            },failureCallBack: {(error) -> Void in
                callBack(error)
        })
        
```
