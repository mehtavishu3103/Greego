//
//  AddpaymentViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/14/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import Alamofire
protocol cardnum {
    func passcard(num:String)
}

class AddpaymentViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtcardnumber: UITextField!
    @IBOutlet weak var txtdate: UITextField!
    @IBOutlet weak var txtcvv: UITextField!
    @IBOutlet weak var txtzipcode: UITextField!
    
    var delegate : cardnum?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtdate.delegate = self
        txtdate.tag = 3
        txtcvv.delegate = self
        txtcvv.tag = 4
      
        txtcardnumber.delegate = self
        txtcardnumber.tag = 2
        
        self.navigationController?.navigationBar.isHidden = true
    }

  
    @IBAction func backbtnaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        
        let str1 = textField.text as NSString?
        let newString = str1?.replacingCharacters(in: range, with: string)
        
        switch textField.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            if (isBackSpace == -92) {
                // print("Backspace was pressed")
            }
            else if newString?.characters.count == 5 || newString?.characters.count == 10 || newString?.characters.count == 15 {
                textField.text = textField.text! + " "
            }
            else if newString?.characters.count == 20 {
                return false
                
            }
            break
        case 3:
            if (isBackSpace == -92) {
                //  print("Backspace was pressed")
            }
            else if newString?.characters.count == 3 {
                textField.text = textField.text! + "/"
            }
            else if newString?.characters.count == 6 {
                return false
                
            }
            break
        case 4:
            if newString?.characters.count == 4 {
                return false
                
            }
            break
        default:
            break
        }
        
        
        return true
    }
    
    @IBAction func btnsavepayment(_ sender: Any) {
        
        if(txtcardnumber.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please enter cardnumber", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtdate.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please enter expirydate", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if(txtcvv.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please enter cvv", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else if(txtzipcode.text == ""){
            let alert = UIAlertController(title: "Alert", message: "Please enter zipcode", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
        
        var fullName: String = self.txtdate.text!
        let fullNameArr = fullName.components(separatedBy: "/")
        
        var firstName: String = fullNameArr[0]
        var lastName: String = fullNameArr[1]
        
       let year = "20" + lastName
        
        let expdate = firstName + "/" + year
        
               if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
           
            var card = self.txtcardnumber.text! as! String
            var str = card.replacingOccurrences(of: " ", with: "")
            
            
            let parameters = [
                "card_number":str,
                    "exp_month_year":expdate,
             
                    "cvv_number":self.txtcvv.text!,
                    "zipcode":self.txtzipcode.text!,
                
                ] as [String : Any]
            Alamofire.request(WebServiceClass().BaseURL+"user/update/card", method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                   if let data = response.result.value{
                        print(response.result.value!)
                    var dic = response.result.value as! NSDictionary
              
                    if(dic.value(forKey: "error_code") as! NSNumber == 0)
                    {
                    
                    //self.delegate?.passcard(num:self.txtcardnumber.text!)
                     self.navigationController?.popViewController(animated: true)
                    
                    }
                    else{
                        let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    }
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
   
}





