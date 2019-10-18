//
//  MemeCollectionViewController.swift
//  PickAnImage
//
//  Created by Ziyad Alsaeed on 10/15/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
import UIKit
class SentMemesCollectionViewController: UICollectionViewController{
    @IBOutlet weak var collectionImage: UIImageView!
    
   
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]!{
    let object = UIApplication.shared.delegate
    let appDelegate = object as! AppDelegate
    return appDelegate.memes
    
}
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemesCollectionViewCell
        let meme = memes[indexPath.row]
        cell
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heightDimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
    
}
}
