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


class MainmapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate, locationDelegate, UIGestureRecognizerDelegate
{
    @IBOutlet weak var btnEditVehicle: UIButton!
    @IBOutlet weak var btnChooseVehicle: UIButton!
    
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
    
    
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblVehicle: UILabel!
    @IBOutlet weak var lblPayment: UILabel!
    
    
    
//MARK: - Delegate Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
            self.setLabelTap()
        
            let button = UIButton(type: UIButtonType.custom)
            
            var image = #imageLiteral(resourceName: "forbes-profile")
            image = image.resize()!
            button.setImage(image, for: UIControlState.normal)
          button.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
           
            button.frame=CGRect(x:0, y:0, width:40, height:40)
            let barButton = UIBarButtonItem(customView: button)
            barButton.target = revealViewController()
            barButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            self.navigationItem.leftBarButtonItems = [barButton]
           
            
           
            
    
    
        viewCarSelection.layer.cornerRadius = 20.0
        viewCarSelection.layer.masksToBounds = true
        
        btnEditVehicle.layer.borderWidth = 1.0
        btnChooseVehicle.layer.borderWidth = 1.0
        
        btnEditVehicle.layer.borderColor = UIColor.darkGray.cgColor
        btnChooseVehicle.layer.borderColor = UIColor.darkGray.cgColor
        
        btnEditVehicle.layer.masksToBounds = true
        btnChooseVehicle.layer.masksToBounds = true
        
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
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        
        self.setLocation()
        self.setLeftView()
        txtSearchPlace.background = UIImage.init(named: "Rectangle 38.png")?.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch)
        self.userMapView.bringSubview(toFront: txtSearchPlace)
        self.txtSearchPlace.isUserInteractionEnabled = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        isExpanded = false
        updateViewHeightContraint.constant = 40.0
        self.navigationController?.isNavigationBarHidden = false

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
//        let marker = GMSMarker(position: center)
//
//        print("Latitude :- \(userLocation!.coordinate.latitude)")
//        print("Longitude :-\(userLocation!.coordinate.longitude)")
//
//        marker.map = self.userMapView
//        marker.title = "Current Location"
        
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
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
    
    
// MARK: - IBAction Methods
    
    @IBAction func sidemenuaction(_ sender: Any)
    {
        
        btn_sidemenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }
    
    @IBAction func btnExpandClicked(_ sender: Any)
    {
        if isExpanded
        {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                self.updatePopUp.heightAnchor.constraint(equalToConstant: 40.0)
                self.updateViewHeightContraint.constant = 40.0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else
        {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                self.updatePopUp.heightAnchor.constraint(equalToConstant: 190.0)
                self.updateViewHeightContraint.constant = 190.0
                self.view.layoutIfNeeded()
            }, completion: nil)
            
           
        }
        isExpanded = !isExpanded
    }
    
    
//MARK: - USER DEFINE FUNCTIONS
    
    func setLabelTap()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.lblProfileAction(gr:)))
        lblProfile.addGestureRecognizer(tap)
        tap.delegate = self
        
        
        let tap2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.lblVehicleAction(gr:)))
        lblVehicle.addGestureRecognizer(tap2)
        tap2.delegate = self
        
        let tap3:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.lblPaymentAction(gr:)))
        lblPayment.addGestureRecognizer(tap3)
        tap3.delegate = self
        
        
        
    }
    @objc func lblProfileAction(gr:UITapGestureRecognizer)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateprofileViewController") as! UpdateprofileViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func lblVehicleAction(gr:UITapGestureRecognizer)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Vehicle_informationViewController") as! Vehicle_informationViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func lblPaymentAction(gr:UITapGestureRecognizer)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Paymentscreen1ViewController") as! Paymentscreen1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
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
        txtSearchPlace.contentMode = .scaleAspectFit

        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "home"))
        imageView.frame = CGRect(x: 20, y: 0, width: 40, height: 40)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        view.addSubview(imageView)
        txtSearchPlace.leftViewMode = UITextFieldViewMode.always
        
        txtSearchPlace.leftView = view
        txtSearchPlace.textRect(forBounds: txtSearchPlace.bounds)
        txtSearchPlace.placeholderRect(forBounds: txtSearchPlace.bounds)
        
        txtSearchPlace.attributedPlaceholder = NSAttributedString(string: "Where do you want to go?",attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
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
extension UIImage{
    
    func resize() -> UIImage? {
        
        let scale = 40.0 / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: 40, height: 40))
        self.draw(in: CGRect(x: 0, y: 0, width: 40, height: 40))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

