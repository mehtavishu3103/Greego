//
//  Paymentscreen1ViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/9/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class Paymentscreen1ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btncancel: UIButton!
    
    @IBOutlet weak var btnadd: UIButton!
    @IBOutlet var promocodeview: UIView!
    @IBAction func txtpromocode(_ sender: Any) {
        
        self.view.addSubview(promocodeview)
        promocodeview.frame = CGRect(x: 10, y: 400, width: self.view.frame.width-20
            , height: 150)
        
        self.view.alpha = 2.0
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "paymentbackimg")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
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
