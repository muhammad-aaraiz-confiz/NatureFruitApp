//
//  CollectionViewCell.swift
//  Events
//
//  Created by Muhammad Aaraiz Wasim on 17/08/2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    func setup(with img: UIImage){
        ImageView.image = img
    }

}
