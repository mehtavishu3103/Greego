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
    
        let camera = GMSCameraPosition.camera(withLatitude: 32.806671, longitude:  -86.791130, zoom: 18);
        self.userMapView.camera = camera
        
        
        let state_marker1 = GMSMarker()
        state_marker1.position = CLLocationCoordinate2D(latitude: 32.806671, longitude: -86.791130)
        state_marker1.title = "Alabama"
        state_marker1.snippet = "Hey, this is Alabama"
        state_marker1.map = self.userMapView
    
        
        self.view.bringSubview(toFront: requestView)

        self.view.sendSubview(toBack: userMapView)
        // Do any additional setup after loading the view.
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
