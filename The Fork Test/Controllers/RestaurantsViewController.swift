//
//  ResturantsViewController.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantsViewController: UITableViewController {
    
    enum CellIdentifier: String {
        case standard
    }
    
    var restaurants: [RestaurantData] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = UIColor.groupTableViewBackground
        
        self.tableView.register(RestaurantCell.self, forCellReuseIdentifier: CellIdentifier.standard.rawValue)
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.title = NSLocalizedString("Restaurants", comment: "")
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .always
        }
        
        self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = Style.Restaurants.tintColor
        self.navigationController?.navigationBar.barTintColor = Style.Restaurants.barTintColor
        self.navigationController?.navigationBar.backgroundColor = Style.Restaurants.backgroundColor
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = Style.Restaurants.prefersLargeTitle
        }
        
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.standardAppearance = Style.Restaurants.navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = Style.Restaurants.navBarAppearance
        }
    }
    
    @objc func downloadData() {
        self.refreshControl?.beginRefreshing()
        let group = DispatchGroup()
        var restaurantsResults = [RestaurantResult]()
        
        let networkOne = NetworkAPI()
        group.enter()
        networkOne.get(restaurant: 211799) {
            restaurant in
            if let restaurant = restaurant {
                restaurantsResults.append(restaurant)
            }
            group.leave()
        }
        
        let networkTwo = NetworkAPI()
        group.enter()
        networkTwo.get(restaurant: 6861) {
            restaurant in
            if let restaurant = restaurant {
                restaurantsResults.append(restaurant)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.restaurants = restaurantsResults.filter({$0.result == 1}).map({$0.data})
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = self.restaurants[indexPath.row]
        let vc = RestaurantViewController(restaurant: restaurant)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.standard.rawValue, for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        cell.setup(with: RestaurantCell.ViewModel(avatarImage: nil, name: restaurant.name, type: "Prova", ratings: restaurant.tripAdvisorAvgRating.description))
        
        if let url = restaurant.picsMain.square92 {
            let network = NetworkAPI()
            network.get(image: url) {
                avatarImage in
                DispatchQueue.main.async {
                    guard let cellForIndexPath = tableView.cellForRow(at: indexPath) as? RestaurantCell else { return }
                    cellForIndexPath.setup(with: RestaurantCell.ViewModel(avatarImage: avatarImage, name: restaurant.name, type: "Prova", ratings: restaurant.tripAdvisorAvgRating.description))
                }
            }
        }

        return cell
    }
    
    func wrappedInNavigation() -> UINavigationController {
        let nav = UINavigationController(rootViewController: self)
        return nav
    }
}
