//
//  LoadingCollectionViewCell.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/15/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class LoadingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
}
