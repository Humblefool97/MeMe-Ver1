//
//  MemeDetailViewController.swift
//  MeMeVer1
//
//  Created by Rajeev Ranganathan on 22/01/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    var meme:Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        detailImageView.image = meme?.memedImage
    }
    
}
