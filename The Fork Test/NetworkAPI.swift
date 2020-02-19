//
//  NetworkAPI.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class NetworkAPI {
    private let session: URLSession
    
    init() {
        self.session = URLSession.shared
    }
    
    func get(restaurant restaurantId: Int, _ handler: @escaping (RestaurantResult?) -> Void) {
        guard let url = URL(string: "https://api.lafourchette.com/api?%20key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=\(restaurantId)") else {
            print("Wrong URL")
            handler(nil)
            return
        }
        
        let task = self.session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                handler(nil)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let restaurant = try decoder.decode(RestaurantResult.self, from: data)
                    handler(restaurant)
                } catch {
                    print(error)
                    handler(nil)
                }
            } else {
                handler(nil)
            }
        }
        
        task.resume()
    }
    
    func get(image url: URL, _ handler: @escaping (UIImage?) -> Void) {
        
        let task = self.session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                handler(nil)
            }
            
            if let data = data, let image = UIImage(data: data) {
                handler(image)
            } else {
                handler(nil)
            }
        }
        
        task.resume()
    }
}
