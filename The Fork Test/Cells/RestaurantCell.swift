//
//  RestaurantCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    struct ViewModel {
        var avatarImage: UIImage?
        var name: String
        var type: String
        var ratings: String
        var isFavourite: Bool = false
    }
    
    let avatarImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 41.0
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        return view
    }()
    
    let typeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    let ratingsLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        return view
    }()
    
    let favoriteImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = .red
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
    
    var infoStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
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
        self.contentView.backgroundColor = UIColor.white
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(typeLabel)
        infoStack.addArrangedSubview(ratingsLabel)
        
        mainStack.addArrangedSubview(avatarImageView)
        mainStack.addArrangedSubview(infoStack)
        mainStack.addArrangedSubview(favoriteImageView)
        
        self.contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: avatarImageView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 92),
            
            NSLayoutConstraint(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: mainStack, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: mainStack, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: mainStack, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 4),
            
            NSLayoutConstraint(item: favoriteImageView, attribute: .width, relatedBy: .equal, toItem: favoriteImageView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: favoriteImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
        ])
    }
    
    func setup(with model: ViewModel) {
        self.nameLabel.text = model.name
        self.typeLabel.text = model.type
        self.ratingsLabel.text = model.ratings
        self.avatarImageView.image = model.avatarImage
        
        if model.isFavourite {
            let image = UIImage(named: "Heart Filled")
            self.favoriteImageView.image = image
        } else {
            let image = UIImage(named: "Heart")
            self.favoriteImageView.image = image
        }
    }
}
