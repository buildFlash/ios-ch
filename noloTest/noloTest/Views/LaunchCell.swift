//
//  LaunchCell.swift
//  noloTest
//
//  Created by Aryan Sharma on 26/07/19.
//  Copyright © 2019 Aryan Sharma. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftDate

class LaunchCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.dropShadow()
    }
    
    func initWith(launch: Launch) {
        if let urlString = launch.links.mission_patch, let url = URL(string: urlString) {
            imgView.kf.setImage(with: url)
        }
        primaryLabel.text = launch.mission_name
        secondaryLabel.text = launch.launch_date_utc.toDate()?.toFormat("YYYY-MM-dd")
    }
    
    
    
}
