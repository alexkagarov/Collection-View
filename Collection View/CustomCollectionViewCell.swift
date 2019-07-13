//
//  CustomCollectionViewCell.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/13/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar.image = nil
    }
    
}
