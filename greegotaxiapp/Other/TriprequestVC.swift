//
//  TriprequestVC.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 09/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
class TriprequestVC: UIViewController {

    @IBOutlet weak var requestView: UIView!
    
    
    @IBOutlet weak var userMapView: GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestView.layer.shadowColor = UIColor.lightGray.cgColor
        requestView.layer.shadowOpacity = 0.5
        requestView.layer.shadowRadius = 2
        
        requestView.layer.cornerRadius = 12.0
        
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "GoogleMap", withExtension: "json")
            {
                userMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
    
        let center = CLLocationCoordinate2D(latitude: 22.9962, longitude: 72.5996)
        
        let center1 = CLLocationCoordinate2D(latitude:23.0063, longitude: 72.6026)
        
        let camera = GMSCameraPosition.camera(withLatitude:23.0063, longitude: 72.6026, zoom: 15);
        self.userMapView.camera = camera
        
        getPolylineRoute(from: center, to: center1)
        
        let marker = GMSMarker()
        marker.position = center
        marker.title = "Maninager"
        marker.appearAnimation = .pop
        marker.map = self.userMapView
        marker.icon = UIImage(named:"marker")

        let marker1 = GMSMarker()
        marker1.position = center1
        marker1.title = "Kankaria"
        marker1.appearAnimation = .pop
        marker1.map = self.userMapView
        marker1.icon = UIImage(named:"marker")

        
        
        
        self.view.bringSubview(toFront: requestView)

        self.view.sendSubview(toBack: userMapView)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    
    
    
   
    
    
    //MARK: - USER DEFINE FUNCTIONS


        func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
       
            
            Alamofire.request("http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        let dic =  response.result.value! as! NSDictionary
                        let routes = dic["routes"] as? [Any]
                        let overview_polyline = routes?[0] as?[String:Any]
                        print(overview_polyline)
                        let polyString = overview_polyline?["overview_polyline"] as? NSDictionary
                        let final = polyString?.value(forKey:"points") as! String
                        //Call this method to draw path on map
                        self.showPath(polyStr: final)
                        
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
                    break
                    
                }
            }
            
            
            
            
            
            
            
            

        }
 
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 6.0
        polyline.strokeColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0)
        polyline.map = self.userMapView // Your map view
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
