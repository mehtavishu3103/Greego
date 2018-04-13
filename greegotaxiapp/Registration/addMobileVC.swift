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
        txtMobileNum.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "usaflag")
        imageView.image = image
        txtMobileNum.leftView = imageView
        txtMobileNum.textInputView.frame.origin.x += 10
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
    
}
