//
//  SettingViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/9/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    
    @IBOutlet weak var firstview: UIView!
    
    @IBOutlet weak var secondview: UIView!
    
    @IBOutlet weak var thirdview: UIView!
    
    @IBOutlet weak var forthview: UIView!
    
    @IBOutlet weak var fifthview: UIView!
    
    @IBOutlet weak var profileimg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileimg.layer.borderWidth=1.0
        profileimg.layer.masksToBounds = false
        profileimg.layer.borderColor = UIColor.white.cgColor
        profileimg.layer.cornerRadius = profileimg.frame.size.height/2
        profileimg.clipsToBounds = true
        
        self.setShadow(view: firstview)
        self.setShadow(view: secondview)
        self.setShadow(view: thirdview)
        self.setShadow(view: forthview)
        self.setShadow(view: fifthview)
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setShadow(view: UIView)
    {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
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
