//
//  RateDistinctionCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RateDistinctionCell: UITableViewCell {
    
    struct ViewModel {
        var rateDistinction: String
        var reviewCount: Int
    }
    
    lazy var rateDistinctionLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .title1)
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        view.numberOfLines = 0
        return view
    }()
    
    lazy var reviewsLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .caption1)
        
        if #available(iOS 13.0, *) {
            view.textColor = .secondaryLabel
        } else {
            view.textColor = .lightGray
        }
        
        view.numberOfLines = 0
        return view
    }()
    
    var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 8.0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        if #available(iOS 13.0, *) {
            self.contentView.backgroundColor = .systemBackground
        } else {
            self.contentView.backgroundColor = .white
        }
    
        mainStack.addArrangedSubview(rateDistinctionLabel)
        mainStack.addArrangedSubview(reviewsLabel)
        
        self.contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainStack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        ])
    }
    
    func setup(with model: ViewModel) {
        
        self.rateDistinctionLabel.text = model.rateDistinction
        
        let reviewString: String
        switch model.reviewCount {
        case 0:
            reviewString = NSLocalizedString("based_on_zero_votes", comment: "")
        case 1:
            reviewString = NSLocalizedString("based_on_one_vote", comment: "")
        default:
            reviewString = String(format: NSLocalizedString("based_on_multiple_votes", comment: ""), model.reviewCount.description)
        }
        
        self.reviewsLabel.text = reviewString
    }
}
