//
//  ReserveView.swift
//  The Fork Test
//
//  Created by Giorgio Romano on 23/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import UIKit

class ReserveButton: UIButton {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = Style.theForkGreenColor
        self.tintColor = .white
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
        self.setTitle(NSLocalizedString("reserve", comment: ""), for: .normal)
    }
}

class ReserveButtonCell: UITableViewCell {

    let button: ReserveButton = {
        let view = ReserveButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
}

class ReserveView: UIView {
    
    private var gradient : CAGradientLayer = CAGradientLayer()
    private var gradientStartColor: UIColor
    private var gradientEndColor: UIColor

    let button: ReserveButton = {
        let view = ReserveButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init() {
        
        if #available(iOS 13.0, *) {
            self.gradientStartColor = UIColor.systemBackground
            self.gradientEndColor = UIColor.systemBackground.withAlphaComponent(0)
        } else {
            self.gradientStartColor = UIColor.white
            self.gradientEndColor = UIColor.white.withAlphaComponent(0)
        }
        
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(button)
        
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                
                NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20),
                NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -20),
                NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20),
                NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 20)
            ])
        } else {
            NSLayoutConstraint.activate([
                
                NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 20),
                NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20),
                NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20),
                NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
            ])
        }
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradient.frame = self.bounds
    }

    override public func draw(_ rect: CGRect) {
        gradient.frame = self.bounds
        gradient.colors = [gradientEndColor.cgColor, gradientStartColor.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0.2, y: 1)
        if gradient.superlayer == nil {
            layer.insertSublayer(gradient, at: 0)
        }
    }
    
    
}
