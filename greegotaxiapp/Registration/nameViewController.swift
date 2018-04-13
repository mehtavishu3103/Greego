//
//  nameViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/2/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class nameViewController: UIViewController
{

    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    
//MARK: - Delegate Methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: txtfirstname.frame.size.height - width, width:  txtfirstname.frame.size.width, height: txtfirstname.frame.size.height)
        
        border.borderWidth = width
        txtfirstname.layer.addSublayer(border)
        txtfirstname.layer.masksToBounds = true
        
        let border1 = CALayer()
        let width1 = CGFloat(2.0)
        border1.borderColor = UIColor.darkGray.cgColor
        border1.frame = CGRect(x: 0, y: txtlastname.frame.size.height - width1, width:  txtlastname.frame.size.width, height: txtlastname.frame.size.height)
        
        border1.borderWidth = width1
        txtlastname.layer.addSublayer(border1)
        txtlastname.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
