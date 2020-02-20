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
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 3000)
        view.backgroundColor = .red
        view.delegate = self
        return view
    }()
    
    internal let baseSliderHeight: CGFloat = 300
    var sliderHeightConstraint: NSLayoutConstraint?
    
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
        
        self.view.addSubview(self.scrollView)
        
        
        if let sliderView = slider.view {
            
            sliderHeightConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: baseSliderHeight)
            
            var constraints = [
                NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                
                NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: sliderView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: scrollView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: scrollView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
            ]
            
            if let constraint = sliderHeightConstraint {
                constraints.append(constraint)
            }
            
            NSLayoutConstraint.activate(constraints)
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

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetHeight = scrollView.contentOffset.y
        let correctedOffsetHeight = offsetHeight / 4
        let newSliderHeight: CGFloat
        
        if correctedOffsetHeight < 200 {
            newSliderHeight = baseSliderHeight - correctedOffsetHeight
        } else {
            newSliderHeight = 100
        }
        self.sliderHeightConstraint?.constant = newSliderHeight
        
        let percentage: Double = Double(correctedOffsetHeight) < 200 ? Double(correctedOffsetHeight) / 200 : 1.0
        self.slider.obfusced(percentage: percentage)
    }
}
