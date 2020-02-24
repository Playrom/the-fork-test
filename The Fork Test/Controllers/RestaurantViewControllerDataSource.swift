//
//  RestaurantViewControllerDataSource.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 24/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantViewControllerDataSource: NSObject, UITableViewDataSource {
    
    let restaurant: RestaurantData
    let tableView: UITableView
    typealias CellIdentifier = RestaurantViewController.CellIdentifier
    
    init(restaurant: RestaurantData, tableView: UITableView) {
        self.restaurant = restaurant
        self.tableView = tableView
    }
    
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
