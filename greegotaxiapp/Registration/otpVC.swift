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
    var strotp: String?

    @IBOutlet weak var lblmsg: UILabel!
    @IBOutlet weak var lbltimer: UILabel!
    
    @IBOutlet weak var btnresend: UILabel!
    @IBOutlet weak var txtMobileNum: SVPinView!
    
    var timer : Timer?
    var count = 60
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        lbltimer.text = "00:00"
        lblmsg.text = "Enter six digit code sent to " + strmobileno!
        
        let tap = UITapGestureRecognizer()
        
        
        tap.addTarget(self, action:#selector(tapresend))
        
        btnresend.addGestureRecognizer(tap)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 60.0, execute: {

         self.strotp = ""
        
        })
        
        
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
        if(strotp == "")
        
        {
           
           
            let alert = UIAlertController(title: "Alert", message: "OTP expired", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if(txtMobileNum.getPin() == strotp)
        {
            
            checkuser()
            
       
            
        }
        
      //  verifyotp()
        }
else
        
     {
        
        let alert = UIAlertController(title: "Alert", message: "Please enter OTP", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
//MARK: - USER DEFINE FUNCTIONS

    
    
    @objc func update() {
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            lbltimer.text = minutes + ":" + seconds
            count -= 1;
            btnresend.isUserInteractionEnabled = false
            if count == 0 {
                timer?.invalidate()
                lbltimer.text = "00:00"
                btnresend.isUserInteractionEnabled = true
            }
        }else{
            timer?.invalidate()
        }
    }
    
    @objc func tapresend()
  {
    
        if AppDelegate.hasConnectivity() == true
        {
            
            let parameters = [
                "contact_number":strmobileno,
                "is_iphone": "0"
            ]
            
            Alamofire.request(WebServiceClass().BaseURL+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                            var datadic :NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                       
                            
                            let otpstring = datadic.value(forKey: "otp") as! NSNumber
                            let devicetoken =  datadic.value(forKey: "token") as! String
                     
                            self.strotp = otpstring.stringValue
                        
                            
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
    
    func checkuser()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            print(UserDefaults.standard.value(forKey: "devicetoken") as! String)
            
            
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]

            
            Alamofire.request(WebServiceClass().BaseURL+"user/update", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        
                        
                        
                        let dic: NSDictionary =  response.result.value! as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber  == 0)
                        {
                       
                            
                            let newdic: NSDictionary = dic.value(forKey: "data") as! NSDictionary
                            
                          if(newdic.value(forKey: "is_agreed") as! String == "0")
                          {
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "EmailVC") as! EmailVC
                            self.navigationController?.pushViewController(nextViewController, animated: true)

                            
                            }
                            else
                           
                            
                          {
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                            
                            }
                            
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
