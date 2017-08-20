//
//  PrevViewController.swift
//  CustomCamera
//
//  Created by Israel Manzo on 8/14/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class PrevViewController: UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        photoImage.image = image
    }
    

    
    
    @IBAction func save(_ sender: Any) {
    }
  

}
