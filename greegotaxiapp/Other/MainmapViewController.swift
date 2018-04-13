//
//  MainmapViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 03/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

<<<<<<< HEAD
<<<<<<< HEAD:greegotaxiapp/MAP/MainmapViewController.swift

class MainmapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate, locationDelegate
<<<<<<< HEAD:greegotaxiapp/Other/MainmapViewController.swift
=======
class MainmapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate
>>>>>>> Greego-Dharika:greegotaxiapp/Other/MainmapViewController.swift
=======
>>>>>>> Greego-Vishal:greegotaxiapp/MAP/MainmapViewController.swift
=======
class MainmapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate,UITextFieldDelegate
>>>>>>> Greego-Jay
{
    
    @IBOutlet weak var updateViewHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var txtSearchPlace: UITextField!

    @IBOutlet weak var btnsidemenu: UIBarButtonItem!

    @IBOutlet weak var btn_sidemenu: UIButton!
    @IBOutlet weak var btnBackToHome: UIButton!
    
    @IBOutlet var viewFirstPopUp: UIView!
    @IBOutlet weak var updatePopUp: UIView!
    @IBOutlet weak var viewCarSelection: UIView!
    
    @IBOutlet weak var userMapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var isExpanded = false
    
    
//MARK: - Delegate Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if revealViewController() != nil
        {
             btn_sidemenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            btnsidemenu.target = revealViewController()
            btnsidemenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            viewCarSelection.layer.cornerRadius = 20.0
            viewCarSelection.layer.masksToBounds = true
        }
        userMapView.delegate = self
        
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
        
        self.setLocation()
        self.setLeftView()
        
        self.userMapView.bringSubview(toFront: txtSearchPlace)
        self.txtSearchPlace.isUserInteractionEnabled = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        isExpanded = false
        updateViewHeightContraint.constant = 40.0
    }
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error" , Error.self)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 18);
        self.userMapView.camera = camera
        self.userMapView.isMyLocationEnabled = true
        let marker = GMSMarker(position: center)
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
       
        marker.map = self.userMapView
        marker.title = "Current Location"
        
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
<<<<<<< HEAD:greegotaxiapp/Other/MainmapViewController.swift
<<<<<<< HEAD:greegotaxiapp/MAP/MainmapViewController.swift
=======
>>>>>>> Greego-Vishal:greegotaxiapp/MAP/MainmapViewController.swift
    
    func closePlacePicker()
    {
        self.navigationController?.popViewController(animated: true)
    }
  
    func sendCordsBack(source:GMSPlace, destination: GMSPlace)
    {
        let sourceMarker = GMSMarker(position: source.coordinate)
        let destMarker = GMSMarker(position: destination.coordinate)
        
        sourceMarker.map = userMapView
        destMarker.map = userMapView
    }
    
//MARK: - TextField Delegate Methods

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseDestinatioVC") as! ChooseDestinatioVC
        self.view.endEditing(true)
        self.navigationController?.pushViewController(vc, animated: true)
        
    
    }
    
=======
>>>>>>> Greego-Dharika:greegotaxiapp/Other/MainmapViewController.swift
    
    
    
    // MARK: - Textfield Delegate Methods

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseDestinatioVC") as! ChooseDestinatioVC
        self.navigationController?.pushViewController(loginVC, animated: true)
        
        return true
        
    }
    
    
    
    
    
    
    
    
    
// MARK: - IBAction Methods
    
    @IBAction func sidemenuaction(_ sender: Any)
    {
        
        btn_sidemenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }
    
    @IBAction func btnExpandClicked(_ sender: Any)
    {
        if isExpanded
        {
            updatePopUp.heightAnchor.constraint(equalToConstant: 40.0)
            updateViewHeightContraint.constant = 40.0
        }
        else
        {
            updatePopUp.heightAnchor.constraint(equalToConstant: 190.0)
            updateViewHeightContraint.constant = 190.0
        }
        isExpanded = !isExpanded
    }
    
    
//MARK: - USER DEFINE FUNCTIONS
    
    func setLocation()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func setLeftView()
    {
        txtSearchPlace.contentMode = .scaleToFill
        
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "photo-camera"))
        imageView.frame = CGRect(x: 0, y: 0, width: txtSearchPlace.frame.size.height-10, height: txtSearchPlace.frame.size.height-10)
        txtSearchPlace.leftViewMode = UITextFieldViewMode.always
        txtSearchPlace.leftView = imageView
        txtSearchPlace.textRect(forBounds: txtSearchPlace.bounds)
        txtSearchPlace.placeholderRect(forBounds: txtSearchPlace.bounds)
    }
    
    func setShadow()
    {
        viewFirstPopUp.layer.cornerRadius = 15.0
        viewFirstPopUp.layer.masksToBounds = true
    }
    
    func showFirstPopUp()
    {
        self.setBluerEffect()
        self.view.bringSubview(toFront: viewFirstPopUp)
        
    }
    func setBluerEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.2
        view.addSubview(blurEffectView)
    }
    
}
