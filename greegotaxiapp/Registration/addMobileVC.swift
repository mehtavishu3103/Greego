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
        
       
        if((txtMobileNum.text?.characters.count)! < 10)
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
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "otpVC") as! otpVC
                    
                    nextViewController.strmobileno = self.txtMobileNum.text!
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
