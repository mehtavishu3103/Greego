//
//  Paymentscreen1ViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 4/17/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit
import Alamofire

class Paymentscreen1ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
 
   
    @IBOutlet weak var promoview: UIView!
    
    @IBOutlet weak var maintableview: UITableView!
    @IBOutlet weak var btnmethod: UIButton!
  
    @IBOutlet weak var btnpromocode: UIButton!
    
    @IBOutlet weak var tablevieheight: NSLayoutConstraint!
    
    @IBOutlet weak var txtpromocode: UITextField!
    
    var paymentarray = NSMutableArray()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnmethod.backgroundColor = .clear
        btnmethod.layer.borderWidth = 1
        btnmethod.layer.borderColor = UIColor.black.cgColor
        
        btnpromocode.backgroundColor = .clear
        btnpromocode.layer.borderWidth = 1
        btnpromocode.layer.borderColor = UIColor.black.cgColor
        promoview.isHidden = true
      
      self.navigationController?.navigationBar.isHidden = true
        let border = CALayer()
                let borderWidth = CGFloat(3.0)
                border.borderColor = UIColor.darkGray.cgColor
                border.frame = CGRect(origin: CGPoint(x: 0,y :txtpromocode.frame.size.height - borderWidth), size: CGSize(width: txtpromocode.frame.size.width, height: txtpromocode.frame.size.height))
                border.borderWidth = borderWidth
                txtpromocode.layer.addSublayer(border)
                txtpromocode.layer.masksToBounds = true
        txtpromocode.layer.masksToBounds = true
      
    }

    @IBAction func backbtnaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        checkpayment()

    }
    
    
       func  checkpayment() {
        let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
        let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
        
        
        Alamofire.request(WebServiceClass().BaseURL+"user/me", method: .post, parameters: [:], encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    
                    let dic = response.result.value as! NSDictionary
                    let data = dic.value(forKey: "data")as! NSDictionary
                    let newary = data.value(forKey: "cards")as! NSArray
                self.paymentarray = newary.mutableCopy() as! NSMutableArray
                    
                    self.maintableview.reloadData()
                    print(response.result.value!)
                }
           
            case .failure(_):
                print("error")
            }
  
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(paymentarray.count == 0){
            tablevieheight.constant = 0
        }
        else if(paymentarray.count == 1){
            tablevieheight.constant = 50
        }
        else if(paymentarray.count == 2){
            tablevieheight.constant = 100
        }
            
        else{
            tablevieheight.constant = 100
        }
        return paymentarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : paymentcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! paymentcell
        
        let dic: NSDictionary =  paymentarray.object(at: indexPath.row)as! NSDictionary
        let decodedData = Data(base64Encoded: dic.value(forKey: "card_number")as! String)!
        let decodedString = String(data: decodedData, encoding: .utf8)!
        cell.lblnum.text = decodedString
   
       cell.numview.layer.borderWidth = 1
        cell.numview.layer.cornerRadius = 5
        cell.numview.layer.borderColor = UIColor.gray.cgColor
    
        let img1 = dic.value(forKey: "selected")as! String
        if(img1 == "0"){
            cell.img.image = UIImage(named: "cross")
        }else{ 
            cell.img.image = UIImage(named: "tick")
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic: NSDictionary =  paymentarray.object(at: indexPath.row)as! NSDictionary

        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want this card as default card?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in

            let id = dic.value(forKey: "id")as! NSNumber
            
            self.selectcard(str: id.stringValue)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
          let dic: NSDictionary =  paymentarray.object(at: indexPath.row)as! NSDictionary
        let id = dic.value(forKey: "id")as! NSNumber
            
            
            let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete this card?", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.deletecard(str: id.stringValue)
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            }))
            
            present(refreshAlert, animated: true, completion: nil)
            
        }
        
        
    }
    
    func deletecard(str:String){
        if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            
            let parameters = [
                "card_id":str
                
                
                ] as [String : Any]
            Alamofire.request(WebServiceClass().BaseURL+"user/delete/card", method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        var dic = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber == 0)
                        {
                            let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            self.checkpayment()
                            
                            
                        }
                        else{
                            let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                case .failure(_):
                    print(response.result.error)
                    break
                    
                }
            }
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
        
        
    }
    
    
    
    func selectcard(str:String){
        if AppDelegate.hasConnectivity() == true
        {
            let token = UserDefaults.standard.value(forKey: "devicetoken") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            
            
            let parameters = [
                "card_id":str
                
                
                ] as [String : Any]
            Alamofire.request(WebServiceClass().BaseURL+"user/select/card", method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if let data = response.result.value{
                        print(response.result.value!)
                        var dic = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! NSNumber == 0)
                        {
                            self.checkpayment()
                            self.maintableview.reloadData()
                            let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                       }
                        else{
                            let alert = UIAlertController(title: "Alert", message:dic.value(forKey: "message") as! String, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                case .failure(_):
                    print(response.result.error)
                    break
                    
                }
            }
            
        }
        else
        {
            NSLog("No Internet Connection")
        }
        
        
    }
    @IBAction func btnaddpaymentaction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddpaymentViewController") as! AddpaymentViewController
        
//        nextViewController.delegate = self as! cardnum
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    @IBAction func btnaddpromocode(_ sender: Any) {
        promoview.isHidden = false
        
        
    }
    
    @IBAction func btncancelaction(_ sender: Any) {
        promoview.isHidden = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
