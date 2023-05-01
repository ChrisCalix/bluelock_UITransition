//
//  Detail2ViewController.swift
//  transitions_demo
//
//  Created by Sonic on 30/4/23.
//

import UIKit

class Detail2ViewController: UIFromAnimatedViewController {
    
    @IBOutlet weak var contentView: UIView!{
        didSet {
            contentViewReservedToAnimate = contentView
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageViewReservedToAnimate = imageView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "Showing Details"
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Demo 2"
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .camera, target: self, action: #selector(name))
    }

    @objc func name() {
        
    }
}
