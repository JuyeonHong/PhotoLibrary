//
//  AlbumTableViewCell.swift
//  PhotoLibrary
//
//  Created by hongjuyeon_dev on 2019/11/11.
//  Copyright © 2019 hongjuyeon_dev. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
