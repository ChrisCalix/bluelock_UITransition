//
//  DetailViewcontroller.swift
//  transitions_demo
//
//  Created by Sonic on 30/4/23.
//

import UIKit

final class DetailViewcontroller: UIFromAnimatedViewController {
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "yoichi")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        self.imageViewReservedToAnimate = image
        self.contentViewReservedToAnimate = contentView
    }
}

