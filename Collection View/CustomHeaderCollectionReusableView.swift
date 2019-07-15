//
//  CustomHeaderCollectionReusableView.swift
//  Collection View
//
//  Created by Alex Kagarov on 7/14/19.
//  Copyright © 2019 Alex Kagarov. All rights reserved.
//

import UIKit

class CustomHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBAction func instructorBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Button pressed", message: "'Find an instructor' was pressed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func schoolBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Button pressed", message: "'Find a school' was pressed!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var leftBtnView: UIView!
    @IBOutlet weak var rightBtnView: UIView!
    
    @IBOutlet weak var leftBtnImg: UIImageView!
    @IBOutlet weak var rightBtnImg: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow(leftBtnView)
        setShadow(rightBtnView)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setRoundImage(leftBtnImg)
        setRoundImage(rightBtnImg)
    }
    
    func setRoundImage(_ image: UIImageView) {
        image.layer.cornerRadius = image.bounds.width / 2
        image.layer.opacity = 0.5
        image.layer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
    }
    
    func setCornerRadius(_ view: UIView) {
        view.layer.cornerRadius = 5
    }
    
    func setShadow(_ view: UIView) {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.1
    }
    
}
