//
//  MemeDetailViewController.swift
//  PickAnImage
//
//  Created by Ziyad Alsaeed on 10/18/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeDetailImage: UIImageView!
    
    var memes: [Meme]{
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.tabBarController?.tabBar.isHidden = true
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
