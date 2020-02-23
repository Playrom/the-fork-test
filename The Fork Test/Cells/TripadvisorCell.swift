//
//  TripadvisorCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class TripadvisorCell: UITableViewCell {
    
    struct ViewModel {
        var bubbles: Double
        var reviewCount: Int
    }
    
    lazy var bubblesImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        view.clipsToBounds = true
        return view
    }()
    
    lazy var reviewsCountLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .caption1)
        view.textAlignment = .left
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        return view
    }()
    
    let buttonView: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Style.theForkGreenColor
        view.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        view.setTitleColor(Style.theForkGreenColor, for: .normal)
        view.titleLabel?.textAlignment = .right
        
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        if #available(iOS 13.0, *) {
            self.contentView.backgroundColor = .systemGroupedBackground
        } else {
            self.contentView.backgroundColor = .groupTableViewBackground
        }
        
        mainStack.addArrangedSubview(bubblesImageView)
        mainStack.addArrangedSubview(reviewsCountLabel)
        mainStack.addArrangedSubview(buttonView)
        
        self.contentView.addSubview(mainStack)
        
        self.buttonView.setTitle(NSLocalizedString("read_more", comment: ""), for: .normal)

        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: mainStack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: mainStack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20),
            
            bubblesImageView.widthAnchor.constraint(equalToConstant: 130),
            bubblesImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setup(with model: ViewModel) {
        
        let integer = Int(model.bubbles)
        let decimal = (model.bubbles.truncatingRemainder(dividingBy: 1))
        var imageName = "Trip_"
        
        if integer < 6 {
            imageName = imageName + integer.description + "_"
        } else {
            imageName = imageName + "0_"
        }
        
        if decimal < 0.5 {
            imageName = imageName + "0"
        } else {
            imageName = imageName + "5"
        }
        
        self.bubblesImageView.image = UIImage(named: imageName)
        
        let reviewString: String
        switch model.reviewCount {
        case 0:
            reviewString = NSLocalizedString("0 votes", comment: "")
        case 1:
            reviewString = NSLocalizedString("1 vote", comment: "")
        default:
            reviewString = String(format: NSLocalizedString("params_votes", comment: ""), model.reviewCount.description)
        }
        
        self.reviewsCountLabel.text = reviewString
    }
}

