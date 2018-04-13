//
//  TripcomplitionVC.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 09/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class TripcomplitionVC: UIViewController {

    
    @IBOutlet weak var innerview: UIView!
    
    
    
    @IBOutlet weak var btn_submit: UIButton!
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        innerview.layer.shadowColor = UIColor.lightGray.cgColor
        innerview.layer.shadowOpacity = 0.5
        innerview.layer.shadowRadius = 2
        
        innerview.layer.cornerRadius = 12.0
        
        btn_submit.layer.cornerRadius = 18.0
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
