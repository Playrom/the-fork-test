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
        view.dataSource = self
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        view.alpha = 0
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
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemGroupedBackground
        } else {
            self.view.backgroundColor = .groupTableViewBackground
        }
        
        self.tableView.register(RestaurantHeaderCell.self, forCellReuseIdentifier: CellIdentifier.header.rawValue)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
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
        
        
        if let sliderView = slider.view {
            
            sliderHeightConstraint = NSLayoutConstraint(item: sliderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: baseSliderHeight)
            
            var constraints = [
                NSLayoutConstraint(item: sliderView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: sliderView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0),
                
                NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: sliderView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
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
        self.favoriteButton.image = image
    }
}

extension RestaurantViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetHeight = scrollView.contentOffset.y
        let correctedOffsetHeight = offsetHeight / 4
        let newSliderHeight: CGFloat
        
        var totalMinimumSliderHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
        let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
        totalMinimumSliderHeight = totalMinimumSliderHeight + statusBarHeight
        
        if correctedOffsetHeight < 200 {
            let calcHeigth = baseSliderHeight - correctedOffsetHeight
            newSliderHeight = calcHeigth > totalMinimumSliderHeight ? calcHeigth : totalMinimumSliderHeight
        } else {
            newSliderHeight = totalMinimumSliderHeight
        }
        self.sliderHeightConstraint?.constant = newSliderHeight
        
        let percentage: Double = Double(correctedOffsetHeight) < 200 ? Double(correctedOffsetHeight) / 200 : 1.0
        self.titleLabel.alpha = CGFloat(percentage)
        self.slider.obfusced(percentage: percentage)
    }
}

extension RestaurantViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.header.rawValue, for: indexPath) as? RestaurantHeaderCell else {
            return UITableViewCell()
        }
        
        var currencyLocale = Locale.current
        if (currencyLocale.currencyCode != restaurant.currencyCode) {
            let identifier = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: restaurant.currencyCode])
            currencyLocale = NSLocale(localeIdentifier: identifier) as Locale
        }
        
        let priceFormatter = NumberFormatter()
        priceFormatter.locale = currencyLocale
        priceFormatter.numberStyle = .currency
        
        var infos = [String]()
        if let avgPriceText = priceFormatter.string(from: NSNumber(value: restaurant.cardPrice)) {
            infos.append(String(format: NSLocalizedString("avg_price", comment: ""), avgPriceText))
        }
        
        if let tagCards = restaurant.restaurantTags.first(where: {$0.id == 5}),
            tagCards.tagList.contains(where: {$0.idRestaurantTag == 311 || $0.idRestaurantTag == 314 || $0.idRestaurantTag == 315 }) {
            infos.append(NSLocalizedString("accepts_cards", comment: ""))
        }
        
        
        cell.setup(with:
            RestaurantHeaderCell.ViewModel(
                types: restaurant.highlightedTag.map({$0.text}),
                info: infos ,
                vote: restaurant.avgRate,
                reviews: restaurant.rateCount
            )
        )
        return cell
    }
    
    
}
