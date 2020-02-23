//
//  MenuItemCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class OptionalFoodCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .headline)
        view.numberOfLines = 0
        view.textAlignment = .left
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
        return view
    }()
    
    let infosLabel: UILabel = {
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
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
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
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infosLabel)
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        ])
    }
    
    func setup(with infos: [String]) {
        self.titleLabel.text = NSLocalizedString("food_requirements", comment: "")
        
        self.infosLabel.text = infos.reduce("", { prev, type in
            if prev == "" {
                return "• " + type + "\n"
            } else {
                return (prev ?? "") + "• " + type + "\n"
            }
        })
    }
}
