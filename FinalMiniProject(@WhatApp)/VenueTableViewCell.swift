//
//  VenueTableViewCell.swift
//  FinalMiniProject(@WhatApp)
//
//  Created by Keith Wong on 7/30/19.
//  Copyright © 2019 Keith Wong. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell
{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rating: RatingTool!
    @IBOutlet weak var photoImage: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
