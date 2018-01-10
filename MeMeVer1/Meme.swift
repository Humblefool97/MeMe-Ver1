//
//  Meme.swift
//  MeMeV1
//
//  Created by Rajeev Ranganathan on 10/01/18.
//  Copyright © 2017 Rajeev Ranganathan. All rights reserved.
//
import Foundation
import UIKit

struct Meme{
    var topText:String
    var bottomText:String
    var originalImage:UIImage
    var memedImage:UIImage
    
    init(topText:String,bottomText:String,originalImage:UIImage, memedImage:UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
}
