//
//  SliderViewController.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 20/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class SliderViewController: UIPageViewController {
    
    let opaqueLayerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.35
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = UIFont.preferredFont(forTextStyle: .title1)
        view.numberOfLines = 0
        return view
    }()
    
    var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var slides: [SlideViewController] = []
    var titleRestaurant: String
    private var currentIndex: Int = 0
    
    init(restaurant: RestaurantData) {
        self.slides = restaurant.picsDiaporama.compactMap({
            picture in
            if let url = picture.w664 {
                let vc = SlideViewController(image: nil)
                let network = NetworkAPI()
                network.get(image: url) {
                    image in
                    DispatchQueue.main.async {
                        vc.image = image
                    }
                }
                return vc
            }
            return nil
        })
        
        self.titleRestaurant = restaurant.name
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([self.slides.first].compactMap({$0}), direction: .forward, animated: false, completion: nil)
        self.setup()
    }
    
    func setup() {
        self.view.addSubview(self.opaqueLayerView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(pageControl)
        
        pageControl.numberOfPages = self.slides.count
                
        self.titleLabel.text = titleRestaurant
        if let view = self.view {
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.opaqueLayerView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.opaqueLayerView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.opaqueLayerView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.opaqueLayerView, attribute: .leading, multiplier: 1, constant: 0),
                
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.titleLabel, attribute: .trailing, multiplier: 1, constant: 20),
                NSLayoutConstraint(item: pageControl, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.titleLabel, attribute: .leading, multiplier: 1, constant: -20),
                
                
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: pageControl, attribute: .trailing, multiplier: 1, constant: 20),
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: pageControl, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: pageControl, attribute: .leading, multiplier: 1, constant: -20),
            ])
        }

    }
}

extension SliderViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let vc = pageViewController.viewControllers?.first as? SlideViewController else { return }
        guard let selectedIndex = self.slides.firstIndex(of: vc) else { return }
        self.pageControl.currentPage = selectedIndex
    }
}

extension SliderViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let before = viewController as? SlideViewController else { return nil }
        guard let index = slides.firstIndex(of: before) else { return nil }
        if index > slides.startIndex {
            self.currentIndex = index - 1
            return slides[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let after = viewController as? SlideViewController else { return nil }
        guard let index = slides.firstIndex(of: after) else { return nil }
        if index < slides.endIndex - 1 {
            self.currentIndex = index + 1
            return slides[index + 1]
        }
        return nil
    }
    
}
