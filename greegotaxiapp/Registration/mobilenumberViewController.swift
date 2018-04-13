//
//  mobilenumberViewController.swift
//  greegotaxiapp
//
//  Created by jay on 4/2/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class mobilenumberViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var logoimg: UIImageView!
    
    
    @IBOutlet weak var txtMobileNum: UITextField!
    
//MARK: - Delegate Methods
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
//MARK: - Textfield Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) 
    {
        textField.endEditing(true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addMobileVC") as! addMobileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
  
}
