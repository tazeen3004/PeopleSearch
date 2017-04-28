//
//  ProfileViewController.swift
//  PeopleSearch
//
//  Created by Tazeen on 27/04/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProfileViewController: UIViewController {
    
    var passedValue:Int?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var compLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func displayUser()
    {
        let object = Array(users.values)[passedValue!]
        Alamofire.request("http://104.215.251.233:81/d_MNetV2/public/images/\(object[6])").responseImage { response in
            debugPrint(response)
        let image = response.result.value
        self.profileImage.image = image
        }
        idLabel.text? = object[0] as! String
        nameLabel.text? = object[1] as! String
        emailLabel.text? = object[4] as! String
        statusLabel.text? = object[5] as! String
        compLabel.text? = object[2] as! String
        branchLabel.text? = object[3] as! String
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage!.clipsToBounds = true
       
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        displayUser()
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
