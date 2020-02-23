//
//  WriteReviewCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class WriteReviewCell: UITableViewCell {

    let button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        view.layer.borderWidth = 1.0
        
        if #available(iOS 13.0, *) {
            view.tintColor = .label
            view.setTitleColor(.label, for: .normal)
            view.layer.borderColor = UIColor.secondaryLabel.cgColor
        } else {
            view.tintColor = .black
            view.setTitleColor(.black, for: .normal)
            view.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        
        view.layer.cornerRadius = 5.0
        view.layer.masksToBounds = true
        
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
        
        self.button.setTitle(NSLocalizedString("write_review", comment: ""), for: .normal)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        ])
    }
}
