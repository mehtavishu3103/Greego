//
//  Vehicle_informationViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/5/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
//import DropDown

class Vehicle_informationViewController: UIViewController {
    
    @IBOutlet weak var dropDown: HADropDown!
    @IBOutlet weak var dropdown3: HADropDown!
    @IBOutlet weak var dropdown2: HADropDown!
    @IBOutlet weak var dropdown4: HADropDown!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dropDown.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown2.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown3.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        dropdown4.items = ["Cat", "Mouse", "Horse", "Elephant", "Dog", "Zebra"]
        
       
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
