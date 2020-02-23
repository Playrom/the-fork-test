//
//  RestaurantHeaderCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 22/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantHeaderCell: UITableViewCell {
    
    struct ViewModel {
        var types: [String]
        var info: [String]
        var vote: Double
        var reviews: Int
    }
    
    lazy var typeLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .headline)
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        view.numberOfLines = 0
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        
        if #available(iOS 13.0, *) {
            view.textColor = .secondaryLabel
        } else {
            view.textColor = .lightGray
        }
        
        view.numberOfLines = 0
        return view
    }()
    
    lazy var voteLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        return view
    }()
    
    lazy var reviewsLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        
        if #available(iOS 13.0, *) {
            view.textColor = .secondaryLabel
        } else {
            view.textColor = .lightGray
        }
        
        return view
    }()
    
    var mainStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 8.0
        return view
    }()
    
    var leftColumnStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 8.0
        return view
    }()
    
    var rightColumnStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .trailing
        view.spacing = 8.0
        return view
    }()
    
    private var model: ViewModel?
    
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
        
        leftColumnStack.addArrangedSubview(self.typeLabel)
        leftColumnStack.addArrangedSubview(self.infoLabel)
        rightColumnStack.addArrangedSubview(self.voteLabel)
        rightColumnStack.addArrangedSubview(self.reviewsLabel)
        
        mainStack.addArrangedSubview(leftColumnStack)
        mainStack.addArrangedSubview(rightColumnStack)
        
        self.contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainStack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20),
            
            typeLabel.centerYAnchor.constraint(equalTo: voteLabel.centerYAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: reviewsLabel.centerYAnchor),
        ])
    }
    
    func setup(with model: ViewModel) {
        self.model = model
        self.typeLabel.text = model.types.reduce("", { prev, type in
            if prev == "" {
                return type
            } else {
                return (prev ?? "") + " • " + type
            }
        })
        
        self.infoLabel.text = model.info.reduce("", { prev, type in
            if prev == "" {
                return type
            } else {
                return (prev ?? "") + " • " + type
            }
        })
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        let voteString = numberFormatter.string(from: NSNumber(value: model.vote)) ?? ""
        
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .headline)]

        let firstString = NSMutableAttributedString(string: voteString, attributes: firstAttributes)
        let secondString = NSAttributedString(string: "/10", attributes: secondAttributes)

        firstString.append(secondString)
        
        self.voteLabel.attributedText = firstString
        
        let reviewString: String
        switch model.reviews {
        case 0:
            reviewString = NSLocalizedString("0 votes", comment: "")
        case 1:
            reviewString = NSLocalizedString("1 vote", comment: "")
        default:
            reviewString = String(format: NSLocalizedString("params_votes", comment: ""), model.reviews.description)
        }
        
        self.reviewsLabel.text = reviewString
    }
}
