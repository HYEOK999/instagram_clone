//
//  ComentTableViewCell.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 06/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class ComentTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var comentLabel: UILabel!
    
    var coment: ComentModel? {
        didSet {
            updateView()
        }
    }
    
    var user: UserModel? {
        didSet {
            setUpUserInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        comentLabel.text = ""
        // Initialization code
    }
    
    func updateView(){
        comentLabel.text = coment?.comentText
    }
    
    func setUpUserInfo(){
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImgUrl{
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholderImg")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
