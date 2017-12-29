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

        Utilities.modelFromUserStringsFor(strSourceLocation: "2635 NE Broadway Street, 97232 (Cha Cha Cha! Mexican Taqueria)", strDestination: "Powellhurst - Gilbert Portland, OR, USA", waypoints: ["3008 NE Broadway Street, 97232","3210 NE Broadway Street, 97232","3017 NE Tillamook Street, 97212"], successCallBack: {[weak self] (mapModel) in
            self?.mapManager.setupMap(mapModel: mapModel) { (mapView, error) in
                guard error == nil else{
                    return
                }
                self?.view = mapView
            }
        }, failureCallBack: {
            Logger.printValue("something went wrong")
        })
        
```

If you want to convert User Defined strings into Lat - Longs use the Geo-coders in Utilities, i have written both the one which which apple provides as well as which google provides , choose one of them.

![alt text](https://github.com/iThink32/Google-Maps-Route-Creator/blob/master/Screen%20Shot%202017-12-30%20at%2012.33.16%20AM.png)

![alt text](https://github.com/iThink32/Google-Maps-Route-Creator/blob/master/Screen%20Shot%202017-12-30%20at%2012.33.40%20AM.png)

![alt text](https://github.com/iThink32/Google-Maps-Route-Creator/blob/master/Screen%20Shot%202017-12-30%20at%2012.33.56%20AM.png)
