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
    @IBOutlet weak var likeBtn: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar.image = nil
    }
    
    override func awakeFromNib() {
        setCustomView()
    }
    
    func setCustomView() {
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
    }
}
