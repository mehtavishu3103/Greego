//
//  UpdateprofileViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/5/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class UpdateprofileViewController: UIViewController {

    @IBOutlet weak var firstsection: UIView!
    @IBOutlet weak var secondsection: UIView!
    @IBOutlet weak var thirdsection: UIView!
    @IBOutlet weak var forthsection: UIView!
    @IBOutlet weak var fifthsection: UIView!
    @IBOutlet weak var sixthsection: UIView!
    @IBOutlet weak var seventhsection: UIView!
    @IBOutlet weak var btnview: UIView!
    
    @IBOutlet weak var updateprofileimg: UIImageView!
    
    @IBOutlet weak var updatebtn: UIButton!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        updateprofileimg.layer.borderWidth=1.0
        updateprofileimg.layer.masksToBounds = false
        updateprofileimg.layer.borderColor = UIColor.white.cgColor
        updateprofileimg.layer.cornerRadius = updateprofileimg.frame.size.height/2
        updateprofileimg.clipsToBounds = true
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.setShadow(view: firstsection)
        self.setShadow(view: secondsection)
        self.setShadow(view: thirdsection)
        self.setShadow(view: forthsection)
        self.setShadow(view: fifthsection)
        self.setShadow(view: sixthsection)
        self.setShadow(view: seventhsection)
        self.setShadow(view: updatebtn)
        self.setShadow(view: btnview)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
//MARK: - User Define Functions
    
    func setShadow(view: UIView)
    {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 2
    }
    @IBAction func btnBackClicked(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    
    }
}
