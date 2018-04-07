//
//  addMobileVC.swift
//  greegotaxiapp
//
//  Created by mac on 06/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

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
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "otpVC") as! otpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
// MARK: - USer Define Functions
    
    func webServiceCall()
    {
        if AppDelegate.hasConnectivity() == true
        {
            
            let strURL = ""
            let urlDictionary = ""
            let postDataDictionary = Dictionary<String, Any>()
            
            WebServiceClass.sharedInstance.callAPIWithURLWithHandler(requestType: strURL, parameters: postDataDictionary, completionHandler: {(success,responseData,urlResponse) in
                
            })
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
        
    }
        
}
