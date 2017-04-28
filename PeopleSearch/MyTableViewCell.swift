//
//  MyTableViewCell.swift
//  PeopleSearch
//
//  Created by Tazeen on 27/04/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var compLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var branchLabel: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var profile: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        self.profile.layer.cornerRadius = self.profile.frame.size.width / 2
        self.profile.clipsToBounds = true
     
    }

}
