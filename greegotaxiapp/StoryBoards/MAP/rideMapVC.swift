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
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var debitCardView: UIView!
    
    let sourceMarker = GMSMarker()
    let destMarker = GMSMarker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
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
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAN4Ri_AE-GyTAPjbk0dJPN9mKXkdZhhJE"
        
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
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 6.0
                    polyline.strokeColor = UIColor.black
                    polyline.map = self.mapView
                    
                    
                    let legs = route["legs"]
                    var strDuration = String()
                    
                    let firstLeg = legs[0]
                        let firstLegDurationDict = firstLeg["duration"]
                    let firstLegDuration = firstLegDurationDict["text"]
                        strDuration = String(describing: firstLegDuration)
                    
                 //   let sourceText = sourceDic!["text"] as! NSString
                    
                    let arrayOfMarkers = [self.sourceMarker,self.destMarker]
                    var bounds = GMSCoordinateBounds()
                    
                        bounds = bounds.includingCoordinate(self.sourceCord)
                        bounds = bounds.includingCoordinate(self.destCord)
                    let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
                    self.mapView.animate(with: update)
                    
                    self.sourceMarker.icon = self.drawText(text:strDuration as NSString , inImage: #imageLiteral(resourceName: "Ellipse 12"))
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
}
