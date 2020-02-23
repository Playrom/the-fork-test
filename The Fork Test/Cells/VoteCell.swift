//
//  VoteCell.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class VoteCell: UITableViewCell {
        
    lazy var voteLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        if #available(iOS 13.0, *) {
            view.textColor = .label
        } else {
            view.textColor = .black
        }
        
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
        
        self.contentView.addSubview(voteLabel)
        
        NSLayoutConstraint.activate([
            
            NSLayoutConstraint(item: voteLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: voteLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: voteLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: voteLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 20)
        ])
    }
    
    func setup(with vote: Double) {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        let voteString = numberFormatter.string(from: NSNumber(value: vote)) ?? ""
        
        let firstAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let secondAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .caption1)]

        let firstString = NSMutableAttributedString(string: voteString, attributes: firstAttributes)
        let secondString = NSAttributedString(string: "/10", attributes: secondAttributes)

        firstString.append(secondString)
        
        self.voteLabel.attributedText = firstString
    }
}
