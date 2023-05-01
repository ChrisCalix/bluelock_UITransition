//
//  ViewController.swift
//  transitions_demo
//
//  Created by Sonic on 30/4/23.
//

import UIKit

class ViewController: UIFromAnimatedViewController {

    private let animatorManager = AnimatorManager(duration: 0.5)
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageViewReservedToAnimate = imageView
        }
    }
    @IBOutlet weak var contentView: UIView! {
        didSet {
            self.contentViewReservedToAnimate = contentView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageViewReservedToAnimate = imageView
    }


    @IBAction func didPressedModeDetail(_ sender: Any) {
        
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail2ViewController") else {
            return
        }
        
//        let nav = UINavigationController(rootViewController: detailVC)
        navigationController?.delegate = animatorManager
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
