//
//  sidemenuViewController.swift
//  greegotaxiapp
//
//  Created by Harshal Shah on 03/04/18.
//  Copyright © 2018 jay. All rights reserved.
//

import UIKit

class sidemenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var imguser: UIImageView!
    
    var reuseid = NSMutableArray()
    
//MARK: - Delegate Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()

        reuseid = ["cell","cell1","cell2","cell3","cell4"]
        imguser.layer.borderWidth=1.0
        imguser.layer.masksToBounds = false
        imguser.layer.borderColor = UIColor.white.cgColor
        imguser.layer.cornerRadius = imguser.frame.size.height/2
        imguser.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
  
    
 //MARK: - TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reuseid.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let str = reuseid.object(at: indexPath.row) as! String
        let dvc:UITableViewCell = tableView.dequeueReusableCell(withIdentifier:str, for: indexPath)
        var nameary = ["Payment","Your Trip","Free Rides","Help","Setting"]
        dvc.textLabel?.text = nameary[indexPath.row]
    
        
        return dvc
    }
    
}
