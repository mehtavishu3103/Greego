//
//  addMobileVC.swift
//  greegotaxiapp
//
//  Created by mac on 06/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import Alamofire
class addMobileVC: UIViewController
{
    @IBOutlet weak var txtMobileNum: UITextField!
    
    
//MARK: - Delegate Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
<<<<<<< HEAD
        txtMobileNum.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "usaflag")
        imageView.image = image
        txtMobileNum.leftView = imageView
        txtMobileNum.textInputView.frame.origin.x += 10
=======
        
      
>>>>>>> Greego-Jay
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - IBAction Methods
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextClicked(_ sender: Any)
    {
        
       
        if(txtMobileNum.text == "")
      {
        let alert = UIAlertController(title: "Alert", message: "Please enter correct mobile number.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
       else
      {
     
        checkmobile()
    
    
       
        }
        }

    
    //MARK: - USER DEFINE FUNCTIONS
func checkmobile()
{
    if AppDelegate.hasConnectivity() == true
    {
        
        let parameters = [
            "contact_number":txtMobileNum.text!,
            "is_iphone": "0"
        ]
        
        Alamofire.request(WebServiceClass().BaseURL+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value!)
                    
                    
                    
                    
                    let dic: NSDictionary =  response.result.value! as! NSDictionary
                    
                   if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                   {
                    var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "otpVC") as! otpVC
                    
                    let otpstring = datadic.value(forKey: "otp") as! NSNumber
                    let devicetoken =  datadic.value(forKey: "token") as! String
                    nextViewController.strmobileno = self.txtMobileNum.text!
                    nextViewController.strotp = otpstring.stringValue
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    let user = UserDefaults.standard
                    
                    user.set(devicetoken, forKey: "devicetoken")
                    user.synchronize()
                    
                    
                    }
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
