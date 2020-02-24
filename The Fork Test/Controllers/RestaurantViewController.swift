//
//  RestaurantViewController.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    enum CellIdentifier: String {
        case header
        case menuItem
        case optionalFood
        case button
        case vote
        case rateDistinction
        case writeReview
        case tripadvisor
        case reserve
    }
    
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
        let view = UIBarButtonItem(image: UIImage(named: "Search"), style: .plain, target: nil, action: nil)
        view.tintColor = UIColor.white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)
        view.textColor = .white
        view.alpha = 0
        return view
    }()
    
    lazy var reserveView: ReserveView = {
        let view = ReserveView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    internal let baseSliderHeight: CGFloat = 300
    fileprivate var sliderHeightConstraint: NSLayoutConstraint?
    fileprivate var reserveViewBottomConstraint: NSLayoutConstraint?
    fileprivate var reserveViewIsDisplayed = true
    fileprivate var dataSource: RestaurantViewControllerDataSource?
    
    var isFavourite: Bool = false
    let restaurant: RestaurantData
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(restaurant: RestaurantData) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGroupedBackground
        } else {
            self.view.backgroundColor = .groupTableViewBackground
        }
        
        self.tableView.register(ButtonCell.self, forCellReuseIdentifier: CellIdentifier.button.rawValue)
        self.tableView.register(RestaurantHeaderCell.self, forCellReuseIdentifier: CellIdentifier.header.rawValue)
        self.tableView.register(MenuItemCell.self, forCellReuseIdentifier: CellIdentifier.menuItem.rawValue)
        self.tableView.register(OptionalFoodCell.self, forCellReuseIdentifier: CellIdentifier.optionalFood.rawValue)
        self.tableView.register(VoteCell.self, forCellReuseIdentifier: CellIdentifier.vote.rawValue)
        self.tableView.register(RateDistinctionCell.self, forCellReuseIdentifier: CellIdentifier.rateDistinction.rawValue)
        self.tableView.register(WriteReviewCell.self, forCellReuseIdentifier: CellIdentifier.writeReview.rawValue)
        self.tableView.register(TripadvisorCell.self, forCellReuseIdentifier: CellIdentifier.tripadvisor.rawValue)
        self.tableView.register(ReserveButtonCell.self, forCellReuseIdentifier: CellIdentifier.reserve.rawValue)
        
        self.dataSource = RestaurantViewControllerDataSource(restaurant: restaurant, tableView: tableView)
        self.tableView.dataSource = self.dataSource
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        self.navigationController?.navigationBar.barStyle = .black
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
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.isHidden = true
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.titleLabel.isHidden = false
        self.titleLabel.alpha = 0
    }
    
    func setup() {
        self.updateFavourite()
        self.navigationItem.rightBarButtonItems = [self.searchButton, self.favoriteButton]
        self.titleLabel.text = restaurant.name
        self.navigationItem.titleView = self.titleLabel

        self.addChild(self.slider)
        view.addSubview(self.slider.view)
        self.slider.didMove(toParent: self)
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.reserveView)
        
        
        if let sliderView = slider.view {
            
            sliderHeightConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: baseSliderHeight)
            
            reserveViewBottomConstraint = NSLayoutConstraint(item: reserveView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
            
            var constraints = [
                NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                
                NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: sliderView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                
                NSLayoutConstraint(item: reserveView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: reserveView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                
                reserveView.heightAnchor.constraint(equalToConstant: 130)
            ]
            
            if let constraint = sliderHeightConstraint {
                constraints.append(constraint)
            }
            
            if let constraint = reserveViewBottomConstraint {
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
        self.favoriteButton.image = image
    }
}

extension RestaurantViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetHeight = scrollView.contentOffset.y
        let correctedOffsetHeight = offsetHeight
        let newSliderHeight: CGFloat
        
        var totalMinimumSliderHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
        totalMinimumSliderHeight = totalMinimumSliderHeight + statusBarHeight
        
        let calcHeigth = baseSliderHeight - correctedOffsetHeight
        
        if calcHeigth > totalMinimumSliderHeight {
            newSliderHeight = calcHeigth
        } else {
            newSliderHeight = totalMinimumSliderHeight
        }
        self.sliderHeightConstraint?.constant = newSliderHeight
        
        let percentage: Double = Double(correctedOffsetHeight) < 200 ? Double(correctedOffsetHeight) / 200 : 1.0
        self.titleLabel.alpha = CGFloat(percentage)
        self.slider.obfusced(percentage: percentage)
        
        if percentage == 1, reserveViewIsDisplayed {
            self.reserveViewBottomConstraint?.constant = 300
            reserveViewIsDisplayed = false
            
            UIView.animate(withDuration: 0.8, delay: 0, options: .allowUserInteraction, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else if percentage < 1, !reserveViewIsDisplayed {
            self.reserveViewBottomConstraint?.constant = 0
            reserveViewIsDisplayed = true
            
            UIView.animate(withDuration: 0.8, delay: 0, options: .allowUserInteraction, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
