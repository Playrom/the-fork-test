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
        view.dataSource = self
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .headline)
        
        if #available(iOS 13.0, *) {
            view.textColor = .white
        } else {
            view.textColor = .white
        }
        
        view.alpha = 0
        return view
    }()
    
    internal let baseSliderHeight: CGFloat = 300
    fileprivate var sliderHeightConstraint: NSLayoutConstraint?
    
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
    }
}

extension RestaurantViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.restaurant.restaurantTags.first(where: {$0.id == 8}) != nil ? restaurant.cardMenu.count + 2 : restaurant.cardMenu.count + 1
        case 2:
            return 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return self.generateRestaurantHeaderCell(indexPath: indexPath)
        case 1:
            if let tag = self.restaurant.restaurantTags.first(where: {$0.id == 8}) {
                if indexPath.row == self.restaurant.cardMenu.endIndex + 1 {
                    return self.generateReadMenuCell(indexPath: indexPath)
                } else if indexPath.row == self.restaurant.cardMenu.endIndex {
                    return self.generateOptionalFoodCell(indexPath: indexPath, with: tag)
                } else {
                    return self.generateMenuItemCell(indexPath: indexPath)
                }
            } else {
                if indexPath.row == self.restaurant.cardMenu.endIndex  {
                    return self.generateReadMenuCell(indexPath: indexPath)
                } else {
                    return self.generateMenuItemCell(indexPath: indexPath)
                }
            }
        case 2:
            switch indexPath.row {
            case 0:
                return self.generateVoteCell(indexPath: indexPath)
            case 1:
                return self.generateRateDistinctionCell(indexPath: indexPath)
            case 2:
                return self.generateReadReviewsCell(indexPath: indexPath)
            case 3:
                return self.generateWriteReviewCell(indexPath: indexPath)
            case 4:
                return self.generateTripadvisorCell(indexPath: indexPath)
            case 5:
                return self.generateReserveCell(indexPath: indexPath)
            default:
                break
            }
            
        default:
            break
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let headerView = HeaderView()
            headerView.setup(with: NSLocalizedString("menu", comment: ""))
            return headerView
        case 2:
            let headerView = HeaderView()
            headerView.setup(with: NSLocalizedString("notes_and_reviews", comment: ""))
            return headerView
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    private func generateRestaurantHeaderCell(indexPath: IndexPath) -> UITableViewCell {
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
    
    private func generateMenuItemCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.menuItem.rawValue, for: indexPath) as? MenuItemCell else {
            return UITableViewCell()
        }
        
        let menuItem = self.restaurant.cardMenu[indexPath.row]
        
        cell.setup(with: MenuItemCell.ViewModel(name: menuItem.name, price: menuItem.price, currencyCode: restaurant.currencyCode))
        
        return cell
    }
    
    private func generateOptionalFoodCell(indexPath: IndexPath, with tag: RestaurantTag) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.optionalFood.rawValue, for: indexPath) as? OptionalFoodCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: tag.tagList.map({$0.tagName}))
        
        return cell
    }
    
    private func generateReadMenuCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.button.rawValue, for: indexPath) as? ButtonCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: .readMenu)
        
        return cell
    }
    
    private func generateVoteCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.vote.rawValue, for: indexPath) as? VoteCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: self.restaurant.avgRate)
        
        return cell
    }
    
    private func generateRateDistinctionCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.rateDistinction.rawValue, for: indexPath) as? RateDistinctionCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: RateDistinctionCell.ViewModel(rateDistinction: restaurant.rateDistinction ?? "", reviewCount: restaurant.rateCount))
        
        return cell
    }
    
    private func generateReadReviewsCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.button.rawValue, for: indexPath) as? ButtonCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: .readReviews)
        
        return cell
    }
    
    private func generateWriteReviewCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.writeReview.rawValue, for: indexPath) as? WriteReviewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func generateTripadvisorCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.tripadvisor.rawValue, for: indexPath) as? TripadvisorCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: TripadvisorCell.ViewModel(bubbles: self.restaurant.tripAdvisorAvgRating, reviewCount: self.restaurant.tripAdvisorReviewCount))
        
        return cell
    }
    
    private func generateReserveCell(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.reserve.rawValue, for: indexPath) as? ReserveButtonCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}
