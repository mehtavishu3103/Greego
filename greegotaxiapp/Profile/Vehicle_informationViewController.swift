//
//  Vehicle_informationViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/5/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
//import DropDown
>>>>>>> Greego-Dharika
=======
>>>>>>> Greego-Vishal
=======
>>>>>>> Greego-Jay

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
<<<<<<< HEAD
    override func viewWillLayoutSubviews() {
        
    }
<<<<<<< HEAD
    override func viewDidLayoutSubviews() {
//        self.dropDown.table.frame = CGRect(x: self.dropDown.frame.origin.x, y: (self.dropDown.frame.origin.y) + (self.dropDown.frame.height)+5, width: (self.dropDown.frame.width), height: 0)
    }
=======
    
    
    override func viewDidLayoutSubviews() {
        
    }


>>>>>>> Greego-Dharika
=======
    override func viewWillLayoutSubviews() {
        
    }
    override func viewDidLayoutSubviews() {
//        self.dropDown.table.frame = CGRect(x: self.dropDown.frame.origin.x, y: (self.dropDown.frame.origin.y) + (self.dropDown.frame.height)+5, width: (self.dropDown.frame.width), height: 0)
    }
>>>>>>> Greego-Vishal
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
