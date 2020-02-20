//
//  RestaurantViewController.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    lazy var slider: SliderViewController = {
        let vc = SliderViewController(restaurant: restaurant)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    lazy var favoriteButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: nil, style: .plain, target:self, action: #selector(self.toggleFavorite))
        view.tintColor = UIColor.white
        return view
    }()
    
    lazy var searchButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: UIImage(named: "Search")?.imageForNavigationBar(), style: .plain, target: nil, action: nil)
        view.tintColor = UIColor.white
        return view
    }()
    
    var isFavourite: Bool = false
    
    let restaurant: RestaurantData
    
    init(restaurant: RestaurantData) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .clear
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        }
            
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setup() {
        self.updateFavourite()
        self.navigationItem.rightBarButtonItems = [self.searchButton, self.favoriteButton]

        self.addChild(self.slider)
        view.addSubview(self.slider.view)
        self.slider.didMove(toParent: self)
        
        if let sliderView = slider.view {
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
            ])
        }
    }
    
    @objc func toggleFavorite() {
        isFavourite = !isFavourite
        updateFavourite()
    }
    
    func updateFavourite() {
        let image: UIImage?
        if isFavourite {
            image = UIImage(named: "Heart Filled")
        } else {
            image = UIImage(named: "Heart")
        }
        self.favoriteButton.image = image?.imageForNavigationBar()
    }
}
