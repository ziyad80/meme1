//
//  MemeTableViewController.swift
//  PickAnImage
//
//  Created by Ziyad Alsaeed on 10/17/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
  
    var memes: [Meme]{
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        cell.memeTableImage.image = meme.memedImage
        cell.memeTableLabel.text = "\(meme.topText) ... \(meme.bottomText)"
     
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        vc.memes = memes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
