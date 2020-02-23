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
    }
    
    private var model: ViewModel?
    
    let avatarImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
//        view.layer.cornerRadius = 41.0
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
    
    let refreshView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
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
        
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(typeLabel)
        infoStack.addArrangedSubview(ratingsLabel)
        
        mainStack.addArrangedSubview(avatarImageView)
        mainStack.addArrangedSubview(infoStack)
        
        self.contentView.addSubview(mainStack)
        self.contentView.addSubview(self.refreshView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: avatarImageView, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: avatarImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 92),
            
            NSLayoutConstraint(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: mainStack, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: mainStack, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: mainStack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8),
            
            refreshView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            refreshView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    func setup(with model: ViewModel) {
        self.model = model
        self.nameLabel.text = model.name
        self.typeLabel.text = model.type
        self.ratingsLabel.text = model.ratings
        if let image = model.avatarImage {
            refreshView.stopAnimating()
            self.avatarImageView.backgroundColor = .clear
            self.avatarImageView.image = image
        } else {
            refreshView.startAnimating()
            self.avatarImageView.backgroundColor = .gray
            self.avatarImageView.image = nil
        }
    }
}
