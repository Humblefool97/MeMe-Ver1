//
//  MemeCollectionViewController.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 20/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class MemeCollectionViewController:UICollectionViewController {
    var memesArray = [Meme]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Collection view")
        self.collectionView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("List view will appear")
        self.tabBarController?.tabBar.isHidden = false

        let delegate = UIApplication.shared.delegate
        let appDelegate = delegate as! AppDelegate
        memesArray = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return memesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memesArray[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = (memesArray[indexPath.row])
        
        collectionViewCell.collectionImage.image=meme.memedImage
        return collectionViewCell
    }
    
    @IBAction func onAddMemeClicked(_ sender: Any) {
        // Get the DiceViewController
        let controller: MemeViewController
        controller = storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as! MemeViewController
        // Present the view Controller
        present(controller, animated: true, completion: nil)
    }
}
