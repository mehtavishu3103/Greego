//
//  ChooseDestinatioVC.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 07/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

let SELECTED_COLOR = UIColor(red:0.00, green:0.58, blue:0.59, alpha:1.0)


class ChooseDestinatioVC: UIViewController, UITextFieldDelegate
{
    

    
    @IBOutlet weak var lblstart: UILabel!
    @IBOutlet weak var lblend: UILabel!
    
    @IBOutlet weak var viewChooseLocation: UIView!
    
    @IBOutlet weak var txtStartLocation: UITextField!
    @IBOutlet weak var txtEndLocation: UITextField!
    
//MARK: - Delegate Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        txtEndLocation.delegate = self
        txtStartLocation.delegate = self
        
        self.setLabelStringAttribs()
        self.setupView()
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

//MARK: - Textfield Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.layer.borderColor = SELECTED_COLOR.cgColor
        textField.layer.borderWidth = 1.0
        
    }
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0.0
    }
    
//MARK: - User Define Methods
    
    func setupView()
    {
        viewChooseLocation.layer.borderColor = UIColor.black.cgColor
        viewChooseLocation.layer.borderWidth = 1.0
//        txtEndLocation.layer.borderColor = SELECTED_COLOR.cgColor
//        txtEndLocation.layer.borderWidth = 1.0
    }

    func setLabelStringAttribs()
    {
        let attrs1 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedStringKey.foregroundColor : SELECTED_COLOR]
        let attrs2 = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 10), NSAttributedStringKey.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"S", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"tart", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string:"E", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string:"nd", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        attributedString3.append(attributedString4)
        
        self.lblstart.attributedText = attributedString1
        self.lblend.attributedText = attributedString3
    }
}
