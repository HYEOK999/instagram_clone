//
//  DisCoverCollectionViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 01/08/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class DisCoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    var post : PostModel? {
        didSet{
            updateView()
        }
    }
    
    func updateView() {
        if let photoUrlString = post?.photoURL{
            let photoUrl = URL(string: photoUrlString)
            photo.kf.setImage(with: photoUrl)
        }
    }
}
