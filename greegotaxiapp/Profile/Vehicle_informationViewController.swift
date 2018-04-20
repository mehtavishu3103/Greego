//
//  Vehicle_informationViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/5/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class Vehicle_informationViewController: UIViewController {
    
    @IBOutlet weak var dropDown: HADropDown!
    @IBOutlet weak var dropdown3: HADropDown!
    @IBOutlet weak var dropdown2: HADropDown!
    @IBOutlet weak var dropdown4: HADropDown!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = true
        
        
        dropDown.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown2.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown3.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown4.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
    }
    override func viewWillLayoutSubviews() {
        
    }
    override func viewDidLayoutSubviews() {
//        self.dropDown.table.frame = CGRect(x: self.dropDown.frame.origin.x, y: (self.dropDown.frame.origin.y) + (self.dropDown.frame.height)+5, width: (self.dropDown.frame.width), height: 0)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
