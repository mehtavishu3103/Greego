//
//  rideMapVC.swift
//  greegotaxiapp
//
//  Created by Viper on 16/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class rideMapVC: UIViewController, GMSMapViewDelegate {

    var sourceCord = CLLocationCoordinate2D()
    var destCord = CLLocationCoordinate2D()
   
    var sourcePlace = String()
    var destPlace = String()
    
     var strDuration = String()
     var strDistance = String()
    
    @IBOutlet weak var lblRatePrice: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var debitCardView: UIView!
    
    @IBOutlet weak var debitCardSubView: UIView!
    let sourceMarker = GMSMarker()
    let destMarker = GMSMarker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        self.debitCardSubView.layer.borderColor = UIColor.darkGray.cgColor
        
        self.debitCardSubView.layer.borderWidth = 1.0
        
        debitCardView.layer.cornerRadius = 20.0
            debitCardView.layer.masksToBounds = true
        
        do {
            if let styleURL = Bundle.main.url(forResource: "GoogleMap", withExtension: "json")
            {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
    
        self.setMarkers()
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackCliked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setMarkers()
    {
      self.drawPath()
    }
    func drawText(text:NSString, inImage:UIImage) -> UIImage? {
    
    let font = UIFont.systemFont(ofSize: 11)
    let size = inImage.size
    
    UIGraphicsBeginImageContext(size)
    
    inImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    let style : NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    style.alignment = .center
        let attributes:NSDictionary = [ NSAttributedStringKey.font : font, NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.foregroundColor : UIColor.black ]
    
        let textSize = text.size(withAttributes: attributes as? [NSAttributedStringKey : Any])
    let rect = CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height)
    let textRect = CGRect(x: (rect.size.width - textSize.width)/2, y: (rect.size.height - textSize.height)/2 - 2, width: textSize.width, height: textSize.height)
    text.draw(in: textRect.integral, withAttributes: attributes as? [NSAttributedStringKey : Any])
    let resultImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return resultImage
    }
    
    
    func drawPath()
    {
        let origin = "\(sourceCord.latitude),\(sourceCord.longitude)"
        let destination = "\(destCord.latitude),\(destCord.longitude)"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyDuLTaJL-tMzdBoTZtCQfCz4m66iEZ1eQc"
        
        Alamofire.request(url).responseJSON { response in
            print(response.request ?? "")  // original URL request
            print(response.response ?? "") // HTTP URL response
            print(response.data ?? "")     // server data
            print(response.result)   // result of response serialization
            do {
                let json = try JSON(data: response.data!)
                
                let routes = json["routes"].arrayValue
                
                for route in routes
                {
                    self.getDrivers()

                        self.getStateCode()
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 6.0
                    polyline.strokeColor = UIColor.black
                    polyline.map = self.mapView
                    
                    
                    let legs = route["legs"]
                    
                    let firstLeg = legs[0]
                        let firstLegDurationDict = firstLeg["duration"]
                    let firstLegDuration = firstLegDurationDict["text"]
                        self.strDuration = String(describing: firstLegDuration)
                    
                    let firstLegDistanceDict = firstLeg["distance"]
                    let firstLegDistance = firstLegDistanceDict["text"]
                    self.strDistance = String(describing: firstLegDistance)
                    
                    
                    var bounds = GMSCoordinateBounds()
                    
                    bounds = bounds.includingCoordinate(self.sourceCord)
                    bounds = bounds.includingCoordinate(self.destCord)
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
                    self.mapView.animate(with: update)
                    
                    self.sourceMarker.icon = self.drawText(text:self.strDuration as NSString , inImage: #imageLiteral(resourceName: "Ellipse 12"))
                    self.sourceMarker.position = CLLocationCoordinate2D(latitude: self.sourceCord.latitude, longitude: self.sourceCord.longitude)
                    self.sourceMarker.map = self.mapView
                
                    
                    self.destMarker.icon = self.drawText(text: "test", inImage: #imageLiteral(resourceName: "est time bubble"))
                    
                    self.destMarker.position = CLLocationCoordinate2D(latitude: self.destCord.latitude, longitude: self.destCord.longitude)
                    self.destMarker.map = self.mapView
                    
                }
            }
            catch _ {
                // Error handling
            }
            
//            if (PFUser.currentUser() != nil) {
//                return true
//            }
        }
    }
    func getStateCode()
    {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(sourceCord.latitude),\(sourceCord.longitude)&key=AIzaSyDuLTaJL-tMzdBoTZtCQfCz4m66iEZ1eQc"
        
        Alamofire.request(url).responseJSON { response in
            print(response.request ?? "")  // original URL request
            print(response.response ?? "") // HTTP URL response
            print(response.data ?? "")     // server data
            print(response.result)   // result of response serialization
            do {
                let json = try JSON(data: response.data!)
                print(json)
                let location = json["results"].arrayValue
                let dicLocation = location[0].dictionaryValue
                print(location)
                let dicTmp = dicLocation["address_components"]?.arrayValue
                let stateCode = dicTmp![6].dictionaryValue
                let state = stateCode["short_name"]?.string
                print(state ?? "")
                
                self.getRate(state: state!)
                
            }
            catch _ {
                // Error handling
            }
            
            //            if (PFUser.currentUser() != nil) {
            //                return true
            //            }
        }
    }
    func getRate(state:String)
    {
        if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            let parameters = [
                "state" : state
                
                ] as [String : Any]
            
            Alamofire.request(WebServiceClass().BaseURL+"user/get/rates", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result)
                {
                case .success(_):
                    if response.result.value != nil
                    {
                        print(response.result.value!)
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        let data = dic.value(forKey: "data")
                        self.setRate(baseFare: data as! NSDictionary)
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error ?? "")
                    break
                    
                }
            }
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
    }
  
    func setRate(baseFare: NSDictionary)
    {
        
        
        let strDis = strDistance.components(separatedBy: " ").first as! String
        let distance = Double(strDis)
        let strDura = strDuration.components(separatedBy: " ").first as! String

        let duration = Double(strDura)
        
        let base = baseFare.value(forKey: "base_fee") as! String
        let mile = baseFare.value(forKey: "mile_fee") as! String
        let overMile = baseFare.value(forKey: "overmile_fee") as! String
        let time = baseFare.value(forKey: "time_fee") as! String
        
       let baseFee = Double(base)
       let mileFee = Double(mile)
       let overMileFee = Double(overMile)
       let timeFee = Double(time)
        

        
        
        var tripPrice = Double()
        if (distance! <= 10.0) {
            tripPrice = baseFee! + (duration! * timeFee!) + (distance! * mileFee!)
        } else {
            let tmpFare = baseFee! + (duration! * timeFee!) + (10 * mileFee!)
            tripPrice = tmpFare + ((distance! - 10) * overMileFee!)
        }
        
        self.lblRatePrice.text = "$" + String(tripPrice)
        print(tripPrice)
    }
    
    @IBAction func btnRequestClicked(_ sender: Any)
    {
        if AppDelegate.hasConnectivity() == true
        {
            let strDis = strDistance.components(separatedBy: " ").first as! String
            let distance = Double(strDis)
            let strDura = strDuration.components(separatedBy: " ").first as! String
            
            let duration = Double(strDura)
            
            let strSourceLat = String(sourceCord.latitude)
            let strsourceLng = String(sourceCord.longitude)
            
            let strDestLat = String(destCord.latitude)
            let strDestLng = String(destCord.longitude)
            
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            let parameters = [
                "user_vehicle_id" : 1,
                "from_address" : self.sourcePlace,
                "from_lat" : strSourceLat,
                "from_lng" : strsourceLng,
                "to_address" : self.destPlace,
                "to_lat" : strDestLat,
                "to_lng" : strDestLng,
                "total_estimated_travel_time" : distance!,
                "total_estimated_trip_cost" : duration!
                ] as [String : Any]

            Alamofire.request(WebServiceClass().BaseURL+"user/add/request", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in

                switch(response.result)
                {
                case .success(_):

                    break
                case .failure(_):
                    print(response.result.error ?? "")
                    break

                }
            }

        }
        else
        {
            NSLog("No Internet Connection")
        }
    }
    func getDrivers()
    {
        if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            let parameters = [
                "lat" : sourceCord.latitude,
                "lng" : sourceCord.longitude
                
                ] as [String : Any]
            
            Alamofire.request(WebServiceClass().BaseURL+"user/get/drivers", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil{
                        print(response.result.value!)
                        
                        
                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        let data = dic.value(forKey: "data") as! NSArray
                        for arr in data
                        {
                            let dicTmp = arr as! Dictionary<String,Any>
                            let marker = GMSMarker()
                            let lat = dicTmp["lat"] as! NSString
                            let lng = dicTmp["lng"] as! NSString
                            marker.position = CLLocationCoordinate2D(latitude: lat.doubleValue , longitude: lng.doubleValue  )
                            marker.title = ""
                            marker.snippet = ""
                            marker.icon = #imageLiteral(resourceName: "user1")
                            marker.map = self.mapView

                        }
                        print(dic)
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error ?? "")
                    break
                    
                }
            }
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
    }
    
}
