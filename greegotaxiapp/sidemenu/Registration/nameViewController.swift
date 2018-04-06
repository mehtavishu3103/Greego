//
//  nameViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/2/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class nameViewController: UIViewController {

    @IBOutlet weak var txtfirstname: UITextField!
    @IBOutlet weak var txtlastname: UITextField!
    
    override func viewDidLoad() {
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
