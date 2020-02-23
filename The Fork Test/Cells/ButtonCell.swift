//
//  ReadMenuCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {

    enum TextType {
        case readMenu
        case readReviews
    }

    let button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Style.theForkGreenColor
        view.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        view.setTitleColor(Style.theForkGreenColor, for: .normal)
        
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
        
        self.contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        ])
    }
    
    func setup(with text: TextType) {
        switch text {
        case .readMenu:
            self.button.setTitle(NSLocalizedString("read_menu", comment: ""), for: .normal)
        case .readReviews:
            self.button.setTitle(NSLocalizedString("read_reviews", comment: ""), for: .normal)
        }
    }
}
