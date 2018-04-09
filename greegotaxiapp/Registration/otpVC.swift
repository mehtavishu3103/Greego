//
//  otpVC.swift
//  greegotaxiapp
//
//  Created by mac on 06/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import Alamofire
import SVPinView
class otpVC: UIViewController {

//MARK: - Delegate Methods
    var strmobileno: String?
    @IBOutlet weak var txtMobileNum: SVPinView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


//MARK: - IBAction Methods
   
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func nextaction(_ sender: Any) {
        
     if(txtMobileNum.getPin() != "")
     {
        
        verifyotp()
        }
else
        
     {
        
        let alert = UIAlertController(title: "Alert", message: "Please enter correct mobile number.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
//MARK: - USER DEFINE FUNCTIONS

    func verifyotp()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            let parameters = [
                "contact_number":strmobileno,
                "is_iphone":txtMobileNum.getPin()
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"verify/otp", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        let user = UserDefaults.standard
                        
                        user.set(self.strmobileno, forKey: "mobile")
                        user.synchronize()
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmailVC") as! EmailVC
                        self.navigationController?.pushViewController(nextViewController, animated: true)

                    }
                    break
                    
                case .failure(_):
                    print(response.result.error)
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
