//
//  SlideViewController.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 20/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            if let img = image {
                self.imageView.image = img
                refreshView.stopAnimating()
            } else {
                refreshView.startAnimating()
            }
        }
    }
    
    init(image: UIImage?) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let refreshView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.refreshView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
            
            refreshView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            refreshView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
