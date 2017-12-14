# Google-Maps-Route-Creator
A Class that creates a GMSPath that can be used to display a path between A and B

VERY IMP:-
DO NOT FORGET TO ADD YOUR API KEY IN

```
class func fetchRouteInformation(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D,successCallBack:@escaping ([String:Any]) -> Void,failureCallBack:@escaping Typealias.MapCallBack)
```
 PRESENT IN THE RouteCreator class!

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
