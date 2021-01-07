//
//  ViewController.swift
//  WImageViewExample
//
//  Created by Ilya Sorokin on 12.11.2020.
//

import UIKit
import WImageView

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: WImageView!
    
    @IBOutlet weak var imageView2: WImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.imageView2.imagePath = "https://dummyimage.com/100x100/0000ff/000000.png"
    }

    @IBAction func buttonTouch(_ sender: Any) {
        self.imageView1.frame.size.width = self.imageView1.frame.width == 100 ? self.view.frame.width : 100
        self.imageView2.frame.size.width = self.imageView2.frame.width == 100 ? self.view.frame.width : 100
    }
    
}

