//
//  ChooseDestinatioVC.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 07/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

let SELECTED_COLOR = UIColor(red:0.00, green:0.58, blue:0.59, alpha:1.0)

protocol locationDelegate:class
{
    func sendCordsBack(source:GMSPlace, destination: GMSPlace)
    func closePlacePicker()
}

class ChooseDestinatioVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate
{
    
    
    @IBOutlet weak var lblstart: UILabel!
    @IBOutlet weak var lblend: UILabel!
    
    @IBOutlet weak var viewChooseLocation: UIView!
    
    @IBOutlet weak var txtStartLocation: UITextField!
    @IBOutlet weak var txtEndLocation: UITextField!
  
    @IBOutlet weak var tblAutoComplete: UITableView!
    
    
    var placesClient : GMSPlacesClient?
    var resultArray  = [GMSPlace]()
    
    var isTxtSource = false
    var isTxtDest = false
   
    var isTxtSourceFilled = false
    var isTxtDestFilled = false
    
    weak var  locDelegate:locationDelegate?
    
    var sourcePlace : GMSPlace?
    var destPlace : GMSPlace?
   
//    var sourcePlace = GMSPlace.init()
//    var destPlace = GMSPlace.init()
//
    let locationManager = CLLocationManager()
//MARK: - Delegate Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.placesClient = GMSPlacesClient()
      //  txtEndLocation.delegate = self
      //  txtStartLocation.delegate = self
        tblAutoComplete.delegate = self
        tblAutoComplete.dataSource = self
        
        
        self.setLabelStringAttribs()
        self.setupView()
//        
//        txtStartLocation.addTarget(self, action: #selector(didChangeText(textField:txtStartLocation)), for: .editingChanged)
//        
        
    }
    
    @IBAction func textDidChange(_ textField: UITextField)
    {
                let currentText = textField.text ?? ""
        if currentText == "" {
            resultArray.removeAll()
            self.tblAutoComplete.reloadData()
            return
        }
                placeAutocomplete(text:currentText)
    }
   
    @IBAction func destTextDidChange(_ textField: UITextField)
    {
        let currentText = textField.text ?? ""
        if currentText == "" {
            resultArray.removeAll()
            self.tblAutoComplete.reloadData()
            return
        }
        placeAutocomplete(text:currentText)
    }
//    @objc func didChangeText(textField:UITextField)
//    {
//        let currentText = textField.text ?? ""
//        placeAutocomplete(text:currentText)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

//MARK: - Textfield Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.layer.borderColor = SELECTED_COLOR.cgColor
        textField.layer.borderWidth = 1.0
        
        
        
      
//        let autoCompleteController = GMSAutocompleteViewController()
//        autoCompleteController.delegate = self
//
//        self.locationManager.startUpdatingLocation()
//        self.present(autoCompleteController, animated: true, completion: nil)
//
        if(textField == txtStartLocation)
        {
            isTxtSource = true
            isTxtDest = false
        }
        else if(textField == txtEndLocation)
        {
            isTxtSource = false
            isTxtDest = true
        }
        else
        {
            isTxtSource = false
            isTxtDest = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0.0
    }
    

//MARK: GoogleAutoComplete Delegate
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if (isTxtSource)
        {
            isTxtSourceFilled = true
       //     sourcePlace = place
            txtStartLocation.text = place.name
            sourcePlace = place
        }
        else
        {
            isTxtDestFilled = true
       //     destPlace = place
            txtEndLocation.text = place.name
            destPlace = place
        }
        
        self.dismiss(animated: true, completion: nil) // dismiss after select place

        
        if (isTxtSourceFilled == true && isTxtDestFilled == true)
        {
            self.locDelegate?.closePlacePicker()
            self.locDelegate?.sendCordsBack(source: sourcePlace!, destination: destPlace!)
        }
        
//        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
//        self.googleMapsView.camera = camera

        
    
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
        print("ERROR AUTO COMPLETE \(error)")
        
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil) // when cancel search
    }
    
    
    
//MARK: - User Define Methods
    
    func placeAutocomplete(text:String) {
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.country = "India"
            
        placesClient?.autocompleteQuery(text, bounds: nil, filter: filter, callback: {(results, error) -> Void in   //unable to enter in this block
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                self.resultArray = [GMSPlace]()
                for result in results {
                    
                    // A hotel in Saigon with an attribution.
                    let placeID = result.placeID;
                    self.placesClient?.lookUpPlaceID(placeID!, callback: { (place, error) -> Void in
                        if let error = error {
                            print("lookup place id query error: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let place = place else {
                            print("No place details for \(String(describing: placeID))")
                            return
                        }
                        
                        if self.resultArray.count <= 5
                        {
                            self.resultArray.append(place)
                        }
                        print("Place name \(place.name)")
                        print("Place address \(String(describing: place.formattedAddress))")
                        print("Place placeID \(place.placeID)")
                        print("Place attributions \(String(describing: place.attributions))")
                         self.tblAutoComplete.reloadData()
                    })
                    
                    print("Result \(result.attributedPrimaryText) with placeID \(String(describing: result.placeID))")
                }
            }
           
        })
    }
    
    
    func setupView()
    {
        viewChooseLocation.layer.borderColor =  UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5).cgColor
        viewChooseLocation.layer.borderWidth = 1.0
        
        viewChooseLocation.layer.masksToBounds = false
        viewChooseLocation.layer.shadowColor = UIColor.black.cgColor
        
        viewChooseLocation.layer.shadowOpacity = 0.5
        viewChooseLocation.layer.shadowOffset = CGSize(width: -1, height: 1)
        viewChooseLocation.layer.shadowRadius = 1
//        txtEndLocation.layer.borderColor = SELECTED_COLOR.cgColor
//        txtEndLocation.layer.borderWidth = 1.0
    }

    func setLabelStringAttribs()
    {
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : SELECTED_COLOR]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"S", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"tart", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:"E", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:"nd", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        attributedString3.append(attributedString4)
        
        self.lblstart.attributedText = attributedString1
        self.lblend.attributedText = attributedString3
    }
}
extension ChooseDestinatioVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        placeAutocomplete(text:currentText)
        return true
    }
   
    
}



extension ChooseDestinatioVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setLocationCell", for: indexPath) as! setLocationCell
        
        let place = resultArray[indexPath.row]
        cell.lblName.text = place.name
        cell.lblAddress.text = place.formattedAddress
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //do something, unable to reach here
    }
}
