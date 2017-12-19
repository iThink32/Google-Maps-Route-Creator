# Google-Maps-Route-Creator
A Class that creates a GMSPath that can be used to display a path between A and B

VERY IMP:-
DO NOT FORGET TO ADD YOUR API KEY IN

```
class func fetchRouteInformation(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D,waypoints:[CLLocationCoordinate2D]?,successCallBack:@escaping ([String:Any]) -> Void,failureCallBack:@escaping Typealias.MapCallBack)
```
 PRESENT IN THE RouteCreator class!

Usage:-

```

        RouteCreater.fetchRouteInformation(from: unwrappedModel.sourceLocation, to: unwrappedModel.destinationLocation,waypoints: unwrappedModel.waypoints,successCallBack: { [weak self](dictReceived) in
            
            //unwrapped path contains an array of legs each leg corresponds to the the path to each waypoint , each leg 
            //has a lot of information that you can use.Ive demonstrated the use of the first leg.You actually have to
            //use the waypointOrder value in the pathInformation object,reorder the legs acc to it and display it in your
            //map for turn by turn navigation.When i implement it i will add it here.
 
            guard let unwrappedSelf = self, let unwrappedPath = RouteCreater.navigationPath(dictPathInformation: dictReceived),unwrappedPath.arrLegs.count > 0,let firstLeg = unwrappedPath.arrLegs.first else{
                callBack(MapError.pathDrawFailed)
                return
            }
            DispatchQueue.main.async {
                unwrappedSelf.currentPolyline = GMSPolyline(path:firstLeg.path)
                unwrappedSelf.currentPolyline?.strokeWidth = 2.0
                unwrappedSelf.currentPolyline?.strokeColor = UIColor.orange
                unwrappedSelf.currentPolyline?.map = unwrappedSelf.mapView
                callBack(nil)
            }
            },failureCallBack: {(error) -> Void in
                callBack(error)
        })
        
```
