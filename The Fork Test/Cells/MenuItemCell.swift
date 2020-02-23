//
//  MenuItemCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    struct ViewModel {
        var name: String
        var price: Double?
        var currencyCode: String
    }
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        view.numberOfLines = 0
        view.textAlignment = .left
        
        if #available(iOS 13.0, *) {
            view.textColor = .secondaryLabel
        } else {
            view.textColor = .lightGray
        }
        
        return view
    }()
    
    let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .headline)
        view.textAlignment = .right
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .top
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
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20),
            
            priceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setup(with model: ViewModel) {
        self.nameLabel.text = model.name
        
        var currencyLocale = Locale.current
        if (currencyLocale.currencyCode != model.currencyCode) {
            let identifier = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: model.currencyCode])
            currencyLocale = NSLocale(localeIdentifier: identifier) as Locale
        }
        
        let priceFormatter = NumberFormatter()
        priceFormatter.locale = currencyLocale
        priceFormatter.numberStyle = .currency
        
        if let price = model.price {
            self.priceLabel.text = priceFormatter.string(from: NSNumber(value: price)) ?? " - "
        } else {
            self.priceLabel.text = " - "
        }
    }
}
