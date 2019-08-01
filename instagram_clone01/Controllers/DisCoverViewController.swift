//
//  DisCoverViewController.swift
//  instagram_clone01
//
//  Created by HYEOKBOOK on 25/07/2019.
//  Copyright © 2019 HYEOKBOOK. All rights reserved.
//

import UIKit

class DisCoverViewController: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    
    var posts : [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVW.delegate = self
        collectionVW.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTopPost()
    }
    
    func loadTopPost() {
        self.posts.removeAll()
        Api.Post.observeTopPosts { (post) in
            self.posts.append(post)
            self.collectionVW.reloadData()
        }
    }
    

}

extension DisCoverViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVW.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DisCoverCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    
    
}

extension DisCoverViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionVW.frame.size.width / 3 - 1, height: collectionVW.frame.size.width / 3 - 1)
    }
}
