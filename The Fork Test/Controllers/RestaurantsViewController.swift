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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(RestaurantCell.self, forCellReuseIdentifier: CellIdentifier.standard.rawValue)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableView.automaticDimension

        self.downloadData()
    }
    
    func downloadData() {
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.standard.rawValue, for: indexPath) as? RestaurantCell else {
            return UITableViewCell()
        }
        
        if let url = restaurant.picsMain.square92 {
            let network = NetworkAPI()
            network.get(image: url) {
                avatarImage in
                DispatchQueue.main.async {
                    cell.setup(with: RestaurantCell.ViewModel(avatarImage: avatarImage, name: restaurant.name, type: "Prova", ratings: restaurant.tripAdvisorAvgRating.description, isFavourite: true))
                }
            }
        } else {
            cell.setup(with: RestaurantCell.ViewModel(avatarImage: nil, name: restaurant.name, type: "Prova", ratings: restaurant.tripAdvisorAvgRating.description, isFavourite: true))
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
