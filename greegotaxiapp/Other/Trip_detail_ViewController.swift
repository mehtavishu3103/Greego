//
//  Trip_detail_ViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/4/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class Trip_detail_ViewController: UIViewController {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var secondview: UIView!
    @IBOutlet weak var thirdview: UIView!
    @IBOutlet weak var mapshadowview: UIView!

    @IBOutlet weak var firstimg: UIImageView!

    @IBOutlet weak var btnshadow: UIButton!
    
    @IBOutlet weak var firstlbl: UILabel!
    @IBOutlet weak var endlbl: UILabel!
   
    
//MARK: - Delegate Methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : UIColor(red:0.00, green:0.58, blue:0.59, alpha:1.0)]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"S", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"tart", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:"E", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:"nd", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        attributedString3.append(attributedString4)
        
        self.firstlbl.attributedText = attributedString1
        self.endlbl.attributedText = attributedString3
        
        firstimg.layer.borderWidth=1.0
        firstimg.layer.masksToBounds = false
        firstimg.layer.borderColor = UIColor.white.cgColor
        firstimg.layer.cornerRadius = firstimg.frame.size.height/2
        firstimg.clipsToBounds = true
       

        
        self.setShadow(view: mainview)
        self.setShadow(view: secondview)
        self.setShadow(view: thirdview)
        self.setShadow(view: mapshadowview)
        self.setShadow(view: btnshadow)


    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
//MARK: - User Define Methods
    
    func setShadow(view: UIView)
    {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        view.layer.shadowRadius = 2
    }

}
