//
//  MeMeListViewController.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 20/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit
import Foundation

class MeMeListViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    private var memesArray = [Meme]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        memesArray = appDelegate.memes
        tableView.reloadData()
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! MemeListViewCell?
        let meme = (memesArray[indexPath.row])
        tableViewCell?.listImageView.image = meme.originalImage
        tableViewCell?.listTextView.text = "\(meme.topText)...\(meme.bottomText)"
        
        return tableViewCell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memesArray[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    fileprivate func navigateToMemeEditor() {
        // Get the DiceViewController
        let controller: MemeViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeViewController
        // Present the view Controller
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func onAddMemeClicked(_ sender: Any) {
        navigateToMemeEditor()
    }
}
